//
//  ContentView.swift
//  SignupForm
//
//  Created by Jungman Bae on 8/6/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Button("기본 스타일") {}
        .buttonStyle(.automatic)
      Button("테두리 스타일") {}
        .buttonStyle(.bordered)
      Button("강조 스타일") {}
        .buttonStyle(.borderedProminent)
      Button("평면 스타일") {}
        .buttonStyle(.plain)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
