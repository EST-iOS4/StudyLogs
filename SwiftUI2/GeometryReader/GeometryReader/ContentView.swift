//
//  ContentView.swift
//  GeometryReader
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    GeometryReader { rootGeometry in
      VStack {
        Text("GeometryReader")
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding()
          .background(Color.blue)
          .frame(width: rootGeometry.size.width,
                 height: rootGeometry.size.height * 0.2)

        Text("Width: \(rootGeometry.size.width)")
        Text("Height: \(rootGeometry.size.height)")
        Text("Safe Area Insets: \(rootGeometry.safeAreaInsets)")

        GeometryReader { geometry in
          HStack(spacing: 1) {
            Rectangle()
              .fill(Color.green)
              .frame(width: geometry.size.width * 0.33,
                     height: geometry.size.height * 0.33)
              .overlay(
                Text("Rectangle")
                  .foregroundColor(.white)
                  .font(.title)
              )
            Rectangle()
              .fill(Color.blue)
              .frame(width: geometry.size.width * 0.33,
                     height: geometry.size.height * 0.33)
              .overlay(
                Text("Rectangle")
                  .foregroundColor(.white)
                  .font(.title)
              )
            Rectangle()
              .fill(Color.green)
              .frame(width: geometry.size.width * 0.33,
                     height: geometry.size.height * 0.33)
              .overlay(
                Text("Rectangle")
                  .foregroundColor(.white)
                  .font(.title)
              )
          }
        }
      }
    }
    .frame(height: 300) // GeometryReader의 높이를 제한

  }
}

#Preview {
  ContentView()
}
