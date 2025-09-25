//
//  ContentView.swift
//  Threading
//
//  Created by Jungman Bae on 9/25/25.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ThreadingViewModel()

  var body: some View {
    VStack {
      if viewModel.isLoading {
        ProgressView()
        Text("백그라운드에서 작업 중...")
      } else {
        Text("결과: \(viewModel.result)")
          .padding()
      }

      Button("무거운 작업 시작") {
        viewModel.performHeavyWork()
      }
      .disabled(viewModel.isLoading)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
