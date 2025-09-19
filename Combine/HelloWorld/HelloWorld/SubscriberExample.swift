//
//  SubscriberExample.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/19/25.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
  @Published var temperature: Double = 20.0
  @Published var isLoading: Bool = false

  func fetchWeather() {
    isLoading = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.temperature = Double.random(in: 15...30)
      self.isLoading = false
    }
  }
}

struct SubscriberExample: View {
  @StateObject private var viewModel = WeatherViewModel()
  @State private var temperatureText = "--"

  var body: some View {
    VStack(spacing: 20) {
      Text("온도: \(temperatureText)°C")
        .font(.system(.largeTitle))

      Button("날씨 업데이트") {
        viewModel.fetchWeather()
      }
      .buttonStyle(.borderedProminent)

      if viewModel.isLoading {
        ProgressView()
      } else {
        EmptyView()
      }
    }
    .onReceive(viewModel.$temperature) {
      temperatureText = String(format: "%.1f", $0)
    }
  }
}

#Preview {
  SubscriberExample()
}
