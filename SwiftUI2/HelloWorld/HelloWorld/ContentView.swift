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
    VStack(alignment: .center, spacing: 10) {
      Text("첫 번째 텍스트")
      Text("텍스트 #2")
      Text("#3")
    }
  }
}

#Preview {
  ContentView()
}
