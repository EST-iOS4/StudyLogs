//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  @State private var value = 0

  var body: some View {
    // alignment: leading, center, trailing
    VStack(alignment: .leading, spacing: 10) {
      Text("첫 번째 텍스트")
      Text("텍스트 #2")
      Text("#3")

      // alignment: top, center, bottom
      HStack(alignment: .bottom) {
        Rectangle()
          .foregroundStyle(.red)
          .frame(width: 10, height: 10)
        Rectangle()
          .foregroundStyle(.blue)
          .frame(width: 30, height: 30)
        Rectangle()
          .foregroundStyle(.orange)
          .frame(width: 100, height: 100)

      }

      HStack {
        ZStack(alignment: .bottomLeading) {
          Rectangle()
            .foregroundStyle(.orange)
            .frame(width: 100, height: 100)
          Rectangle()
            .foregroundStyle(.blue)
            .frame(width: 30, height: 30)
          Rectangle()
            .foregroundStyle(.red)
            .frame(width: 10, height: 10)

        }
        ZStack(alignment: .topTrailing) {
          Rectangle()
            .foregroundStyle(.orange)
            .frame(width: 100, height: 100)
          Rectangle()
            .foregroundStyle(.blue)
            .frame(width: 30, height: 30)
          Rectangle()
            .foregroundStyle(.red)
            .frame(width: 10, height: 10)

        }
      }
      HStack {
        ZStack(alignment: .center) {
          Rectangle()
            .foregroundStyle(.orange)
            .frame(width: 100, height: 100)
          Rectangle()
            .foregroundStyle(.blue)
            .frame(width: 30, height: 30)
          Rectangle()
            .foregroundStyle(.red)
            .frame(width: 10, height: 10)

        }
        ZStack(alignment: .trailing) {
          Rectangle()
            .foregroundStyle(.orange)
            .frame(width: 100, height: 100)
          Rectangle()
            .foregroundStyle(.blue)
            .frame(width: 30, height: 30)
          Rectangle()
            .foregroundStyle(.red)
            .frame(width: 10, height: 10)

        }
      }

    }
  }
}

#Preview {
  ContentView()
}
