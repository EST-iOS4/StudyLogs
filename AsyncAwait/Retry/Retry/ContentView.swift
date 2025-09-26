//
//  ContentView.swift
//  Retry
//
//  Created by Jungman Bae on 9/26/25.
//

import SwiftUI

struct RetryButton: View {
  let action: () async throws -> Void
  let title: String

  @State private var isLoading = false
  @State private var showError = false
  @State private var errorMessage = ""

  var body: some View {
    Button(action: {
      Task {
        await performAction()
      }
    }) {
      HStack {
        if isLoading {
          ProgressView()
            .scaleEffect(0.8)
        }
        Text(isLoading ? "처리 중..." : title)
      }
    }
    .disabled(isLoading)
    .alert("오류", isPresented: $showError) {
      Button("재시도") {
        Task {
          await performAction()
        }
      }
      Button("취소", role: .cancel) {}
    } message: {
      Text(errorMessage)
    }
  }

  @MainActor
  private func performAction() async {
    isLoading = true
    defer { isLoading = false }
    do {
      try await action()
      showError = false
    } catch {
      errorMessage = error.localizedDescription
      showError = true
    }
  }
}

struct ContentView: View {
  private let networkService = NetworkService()

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
      RetryButton(action: {
        try await networkService.updateProfile()
      }, title: "프로필 업데이트")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
