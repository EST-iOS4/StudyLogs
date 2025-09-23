//
//  ContentView.swift
//  OpenWeather
//
//  Created by Jungman Bae on 9/23/25.
//

import SwiftUI

struct WeatherView: View {
  @State private var service = WeatherService()

  var body: some View {
    VStack {
      if service.isLoading {
        ProgressView("날씨 정보 로딩 중...")
      } else if let weather = service.weather {
        VStack {
          Text(weather.city).font(.title)
          Text("\(weather.temperature)°C").font(.largeTitle)
          Text(weather.description)
        }
      } else if let message = service.errorMessage {
        Text(message).foregroundColor(.red)
      }

      Button("날씨 확인") {
        service.fetchWeather()
      }
    }
    .padding()
    .onAppear { service.fetchWeather() }
  }
}

#Preview {
  WeatherView()
}
