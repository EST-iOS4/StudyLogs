//
//  OperatorExample.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/19/25.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
  @Published var searchText = ""
  @Published private(set) var searchResults: [String] = []

  private let allItems = [
    "사과", "사과주스", "바나나", "바나나우유", "오렌지",
    "오렌지주스", "포도", "포도주스", "딸기", "딸기우유"
  ]

  init() {
    $searchText
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .map { [allItems] term in
        term.isEmpty ? allItems : allItems.filter { $0.contains(term) }
      }
      .assign(to: &$searchResults)
  }
}

struct OperatorExample: View {
  @StateObject private var viewModel = SearchViewModel()

  var body: some View {
    VStack {
      TextField("검색어 입력", text: $viewModel.searchText)
        .textFieldStyle(.roundedBorder)

      List(viewModel.searchResults, id: \.self) { item in
        Text(item)
      }
    }
  }
}

#Preview {
  OperatorExample()
}
