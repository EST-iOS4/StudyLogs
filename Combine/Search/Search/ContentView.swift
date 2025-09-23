//
//  ContentView.swift
//  Search
//
//  Created by Jungman Bae on 9/23/25.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = DataViewModel()

  var body: some View {
    NavigationStack {
      if viewModel.isLoading {
        ProgressView("로딩 중...")
      } else if !viewModel.errorMessage.isEmpty {
        ErrorView(
          message: viewModel.errorMessage,
          retry: viewModel.fetchData
        )
      } else {
        switch viewModel.phase {
        case .idle:
          DataListView(data: viewModel.data)
        case .empty:
          Text("데이터가 없습니다.")
        case .results(let results):
          DataListView(data: results)
        case .loading:
          ProgressView("로딩 중...")
        case .failed(_):
          Text("오류")
        }
      }
        EmptyView()
          .searchable(text: $viewModel.searchText, isPresented: .constant(true))
    }
    .onAppear {
      viewModel.fetchData()
    }
  }
}

#Preview {
  ContentView()
}
