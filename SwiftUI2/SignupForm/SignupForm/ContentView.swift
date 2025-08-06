//
//  ContentView.swift
//  SignupForm
//
//  Created by Jungman Bae on 8/6/25.
//

import SwiftUI

struct ContentView: View {
  @State var isOn: Bool = false
  @State var sliderValue: Double = 50.0

  var body: some View {
    VStack {
      Button("기본 스타일") {}
        .buttonStyle(.automatic)
      Button("테두리 스타일") {}
        .buttonStyle(.bordered)
      Button("강조 스타일") {}
        .buttonStyle(.borderedProminent)
      Button("평면 스타일") {}
        .buttonStyle(.plain)

      TextField("이메일", text: .constant(""))
        .textFieldStyle(.roundedBorder)
        .autocorrectionDisabled()
        .padding()

      Toggle(isOn: $isOn, label: {
        Text("알림 받기")
      })

      Slider(value: $sliderValue, in: 0...100, step: 10) {
        Text("볼륨")
      }
      Text("볼륨: \(Int(sliderValue))")
        .padding()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
