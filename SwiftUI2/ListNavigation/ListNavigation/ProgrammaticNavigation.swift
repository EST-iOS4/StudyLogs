//
//  ProgrammaticNavigation.swift
//  ListNavigation
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct ProgrammaticNavigation: View {
  @State private var path = NavigationPath()

  var body: some View {
    NavigationStack(path: $path) {
      VStack(spacing: 20) {
        Button("숫자 화면으로 이동") {
          path.append(42) // 숫자 화면으로 이동
        }

        Button("텍스트 화면으로 이동") {
          path.append("Hello") // 상세 화면으로 이동
        }
      }
      .navigationDestination(for: Int.self) { number in
        DetailView(number: number)
      }
      .navigationDestination(for: String.self) { text in
        TextDetailView(text: text)
      }
      .navigationTitle("홈")
    }
  }
}

struct DetailView: View {
  var number: Int

  var body: some View {
    Text("상세화면 \(number)")
      .font(.largeTitle)
      .padding()
  }
}

struct TextDetailView: View {
  var text: String

  var body: some View {
    Text("텍스트 상세: \(text)")
      .font(.largeTitle)
      .padding()
  }
}


#Preview {
  ProgrammaticNavigation()
}
