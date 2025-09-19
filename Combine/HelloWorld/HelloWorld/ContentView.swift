//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/19/25.
//

import SwiftUI
internal import Combine

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
  .autoconnect()


struct ContentView: View {
  @State private var currentTime = Date()

  private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter
  }()

  var body: some View {
    Text("현재 시간: \(currentTime, formatter: timeFormatter)")
      .onReceive(timerPublisher) { time in
        currentTime = time
      }
  }
}

#Preview {
    ContentView()
}
