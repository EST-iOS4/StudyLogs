//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  let myString = 43

  var body: some View {
    Button {
      print("click!") // 실행 코드
    } label: {
      Text("Click here")
        .font(.largeTitle)
        .foregroundStyle(.green)
        .padding()
        .border(.red, width: 6)
    }
  }
}

#Preview {
  ContentView()
}
