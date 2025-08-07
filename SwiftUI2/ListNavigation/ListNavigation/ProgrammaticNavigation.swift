//
//  ProgrammaticNavigation.swift
//  ListNavigation
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct ProgrammaticNavigation: View {
  @State private var path = NavigationPath()

  // Clamped 프로퍼티 래퍼를 사용하여 값 제한 사용예시
  @Clamped(min: 0, max: 100) var clampedValue: Int = 100

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
        DetailView(path: $path, number: number)
      }
      .navigationDestination(for: String.self) { text in
        TextDetailView(text: text)
      }
      .navigationTitle("홈")
    }
  }
}

struct DetailView: View {
  @Binding var path: NavigationPath
  var number: Int

  var body: some View {
    VStack {
      Text("숫자 상세화면 \(number)")
        .font(.largeTitle)
        .padding()

      Button("숫자 상세 화면으로 이동") {
        path.append(Int.random(in: 1...100)) // 랜덤 숫자 화면으로 이동
      }

      Button("뒤로 가기") {
        path.removeLast() // 뒤로 가기
      }

      Button("홈으로 이동") {
        path.removeLast(path.count) // 홈으로 이동
      }
    }
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
