//
//  OperatorExample.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/19/25.
//

import SwiftUI
import Combine

@Observable
class SearchViewModel {
  var searchText = "" {
    didSet {
      // searchText 변경 → subject 로 전송
      searchTextSubject.send(searchText)
    }
  }
  private(set) var searchResults: [String] = []

  private let allItems = [
    "사과", "사과주스", "바나나", "바나나우유", "오렌지",
    "오렌지주스", "포도", "포도주스", "딸기", "딸기우유"
  ]

  // Combine 스트림용 subject
  private let searchTextSubject = PassthroughSubject<String, Never>()
  private var cancellables = Set<AnyCancellable>()

  init() {
    searchTextSubject
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .map { [allItems] term in
        term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        ? allItems
        : allItems.filter { $0.contains(term) }
      }
      .assign(to: \.searchResults, on: self)
      .store(in: &cancellables)

    // 초기값도 반영
    searchTextSubject.send(searchText)
  }
}

struct OperatorExample: View {
  @State private var viewModel = SearchViewModel()

  var body: some View {
    VStack {
      TextField("검색어 입력", text: $viewModel.searchText)
        .textFieldStyle(.roundedBorder)

      List(viewModel.searchResults, id: \.self) { item in
        Text(item)
      }
    }
    .padding()
  }
}

#Preview {
  OperatorExample()
}
