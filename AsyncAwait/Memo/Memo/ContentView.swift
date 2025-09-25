//
//  ContentView.swift
//  Memo
//
//  Created by Jungman Bae on 9/25/25.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = MemoViewModel()

  var body: some View {
    NavigationStack {
      TextEditor(text: $viewModel.text)
        .padding()
        .navigationTitle("Memo")
        .task {
          await viewModel.load()
        }
        .onChange(of: viewModel.text) { _, _ in
          viewModel.scheduleSave()
        }
    }
  }
}

#Preview {
  ContentView()
}
