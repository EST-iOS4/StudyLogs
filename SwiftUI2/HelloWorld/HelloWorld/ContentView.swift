//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  @State private var isOn = true

  var body: some View {
    Text("Here's a secret message!")
      .background(Color.yellow)
      .padding()
  }
}

#Preview {
  ContentView()
}
