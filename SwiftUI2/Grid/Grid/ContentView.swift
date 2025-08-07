//
//  ContentView.swift
//  Grid
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct ContentView: View {
  let columns = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100))
  ]

  let adaptiveColumns = [
    GridItem(.adaptive(minimum: 100))
  ]

  let mixedColumns = [
    GridItem(.fixed(100)),
    GridItem(.flexible()),
    GridItem(.adaptive(minimum: 50))
  ]

  var body: some View {
    ScrollView(.horizontal) {
      LazyHGrid(rows: columns, spacing: 20) {
        ForEach(0..<30) { index in
          Rectangle()
            .fill(Color.blue)
            .frame(width: 100)
            .overlay(
              Text("\(index)")
                .foregroundColor(.white)
                .font(.headline)
            )
        }
      }
    }
    ScrollView {
      LazyVGrid(columns: adaptiveColumns, spacing: 20) {
        ForEach(0..<30) { index in
          Rectangle()
            .fill(Color.red)
            .frame(height: 100)
            .overlay(
              Text("\(index)")
                .foregroundColor(.white)
                .font(.headline)
            )
        }
      }

      LazyVGrid(columns: mixedColumns, spacing: 20) {
        ForEach(0..<30) { index in
          Rectangle()
            .fill(Color.green)
            .frame(height: 100)
            .overlay(
              Text("\(index)")
                .foregroundColor(.white)
                .font(.headline)
            )
        }
      }

    }
  }
}

#Preview {
  ContentView()
}
