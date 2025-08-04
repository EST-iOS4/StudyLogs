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
    Stepper(value: $value, in: 0...10) {
      Text("값: \(value)")
        .background(.yellow)
        .font(.largeTitle)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
