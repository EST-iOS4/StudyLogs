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
    Stepper("값: \(value)", value: $value, in: 0...10)
      .padding()
  }
}

#Preview {
  ContentView()
}
