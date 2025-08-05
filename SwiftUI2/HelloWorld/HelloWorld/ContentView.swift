//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedColor: Color = .blue
  @State private var date: Date = Date()

  var body: some View {
    VStack {
      ColorPicker(selection: $selectedColor) {
        Text("Select a color")
          .foregroundColor(.primary)
      }

      DatePicker(
        "Select a date",
        selection: $date,
        displayedComponents: [.date, .hourAndMinute]
      )
      // .wheel, .compact, .graphical 스타일을 사용할 수 있습니다.
      .datePickerStyle(.compact)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
