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
    Toggle("Toggle Example", isOn: $isOn)
      .padding()
  }
}

#Preview {
  ContentView()
}
