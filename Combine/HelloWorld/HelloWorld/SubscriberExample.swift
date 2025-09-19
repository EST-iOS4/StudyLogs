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
    // 실제 네트워크 호출 대신 2초 지연 후 값 갱신
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.temperature = Double.random(in: 15...30)
      self.isLoading = false
    }
  }
}

final class TemperatureFormatter: ObservableObject {
  private let weather: WeatherViewModel
  @Published var displayText = "--"
  private var cancelables = Set<AnyCancellable>()

  init(weather: WeatherViewModel = .init()) {
    self.weather = weather

    weather.$temperature
      .map { String(format: "%.1f", $0) }
      .sink { [weak self] formatted in
        self?.displayText = formatted
      }
      .store(in: &cancelables)
  }

  func refresh() {
    weather.fetchWeather()
  }
}

struct SubscriberExample: View {
  @StateObject private var viewModel = TemperatureFormatter()

  var body: some View {
    VStack(spacing: 20) {
      Text("온도: \(viewModel.displayText)°C")
        .font(.system(.largeTitle))

      Button("날씨 업데이트") {
        viewModel.refresh()
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  SubscriberExample()
}
