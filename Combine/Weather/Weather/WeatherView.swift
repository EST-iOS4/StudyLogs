//
//  ContentView.swift
//  Weather
//
//  Created by Jungman Bae on 9/22/25.
//

import SwiftUI

struct WeatherView: View {
  @StateObject private var service = WeatherService()

  var body: some View {
    VStack(spacing: 16) {
      if service.isLoading {
        ProgressView("날씨 불러오는 중…")
      } else if let w = service.weather {
        VStack(spacing: 8) {
          Text(w.city).font(.title)
          Text(String(format: "%.1f°C", w.temperatureC)).font(.largeTitle)
          Text(w.description).foregroundColor(.secondary)
        }
      } else if !service.errorMessage.isEmpty {
        Text(service.errorMessage).foregroundColor(.red)
      } else {
        Text("버튼을 눌러 날씨를 확인하세요")
      }

      Button("서울 날씨 확인") { service.fetchSeoul() }
        .buttonStyle(.borderedProminent)
    }
    .padding()
  }
}

#Preview {
  WeatherView()
}
