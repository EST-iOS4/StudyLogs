//
//  ContentView.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = DataViewModel()

  var body: some View {
    Group {
      if viewModel.isLoading {
        ProgressView("로딩 중...")
      } else if !viewModel.errorMessage.isEmpty {
        ErrorView(
          message: viewModel.errorMessage,
          retry: viewModel.fetchData
        )
      } else {
        DataListView(data: viewModel.data)
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
