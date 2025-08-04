//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Text("위")
      HStack {
        Text("왼쪽")
        Text("오른쪽")
      }
      ZStack {
        Text("배경")
        Text("전경")
      }
    }
    .font(.largeTitle)
    .padding()
  }
}

#Preview {
  ContentView()
}
