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
    Text("This is my age \(myString). Since I am retired, I am now eligible for a pension and Social Security so I can spend the rest of my life relaxing and enjoying life without having to work for an income anymore.")
      .lineLimit(2)
      .truncationMode(.tail)
      .font(.custom("Courier", size: 24))
      .fontWeight(.semibold)
      .foregroundStyle(.red)
      .padding()
    Label("Text", systemImage: "car.fill")
      .labelStyle(TrailingIconLabelStyle())
      .font(.custom("Courier", size: 24))

    Label {
      Text("Modifiers")
        .font(.title)
    } icon: {
      Image(systemName: "flag.fill")
        .opacity(0.25)
    }
  }
}

// 커스텀 LabelStyle: 아이콘을 텍스트 뒤에 배치
struct TrailingIconLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.title
      configuration.icon
    }
  }
}

#Preview {
  ContentView()
}
