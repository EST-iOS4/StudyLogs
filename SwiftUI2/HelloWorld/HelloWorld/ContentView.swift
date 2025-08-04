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
    Text("위치 수정자 예제")
      .offset(x: 50, y: 100)
      .position(x: 200, y: 300)
  }
}

#Preview {
  ContentView()
}
