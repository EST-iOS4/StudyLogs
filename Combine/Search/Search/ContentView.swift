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
        DataListView(data: viewModel.data)
          .searchable(text: $viewModel.searchText, isPresented: .constant(true))
      }
    }
    .onAppear {
      viewModel.fetchData()
    }
  }
}

#Preview {
  ContentView()
}
