//
//  ErrorView.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import SwiftUI

struct ErrorView: View {
  let message: String
  let retry: () -> Void

  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "exclamationmark.triangle")
        .font(.largeTitle)
        .foregroundColor(.orange)

      Text("오류가 발생했습니다")
        .font(.headline)

      Text(message)
        .multilineTextAlignment(.center)
        .foregroundColor(.secondary)

      Button("다시 시도", action: retry)
        .buttonStyle(.bordered)
    }
    .padding()
  }}
