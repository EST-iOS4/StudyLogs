//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  @State private var myColor = Color.red
  var body: some View {
    VStack {
      Picker("Select an option", selection: $myColor) {
        Text("Red").tag(Color.red)
        Text("Green").tag(Color.green)
        Text("Blue").tag(Color.blue)
      }
      .pickerStyle(.segmented)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
