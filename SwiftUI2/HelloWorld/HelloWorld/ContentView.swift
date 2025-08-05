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

      Circle()
        .fill(myColor)
        .frame(width: 150, height: 150)
        .overlay(
          Text("Selected Color")
            .foregroundColor(.white)
            .font(.title)
        )
    }
    .padding()
    .onChange(of: myColor, initial: true) {
      print("Selected color changed to: \(myColor.description)")
    }
  }
}

#Preview {
  ContentView()
}
