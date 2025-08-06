//
//  ContentView.swift
//  HelloWorld2
//
//  Created by Jungman Bae on 8/6/25.
//

import SwiftUI

struct ContentView: View {
  @State private var name = ""
  @State private var showGreeting = false

  var body: some View {
    VStack(spacing: 20) {
      Text("SwiftUI 환영 앱")
        .font(.largeTitle)
        .fontWeight(.bold)

      TextField("이름을 입력하세요", text: $name)
        .textFieldStyle(.roundedBorder)
        .padding()

      Button("인사하기") {
        showGreeting.toggle()
      }
      .buttonStyle(.borderedProminent)
      .disabled(name.isEmpty)

      if showGreeting && !name.isEmpty {
        Text("안녕하세요, \(name)!")
          .font(.title2)
          .foregroundColor(.blue)
          .transition(.scale)
          .animation(.spring(), value: showGreeting)
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
