//
//  WeatherService.swift
//  OpenWeather
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation
import SwiftUI
import Combine

struct Weather: Codable {
  let city: String
  let temperature: Int
  let description: String
}

// OpenWeather 응답(JSON)을 디코딩하기 위한 모델
// class 요청 주셔서 class로 정의했지만, 이 용도는 struct가 일반적입니다.
final class OpenWeatherResponse: Codable {
  struct Main: Codable {
    let temp: Double
  }
  struct WeatherItem: Codable {
    let id: Int?
    let main: String?
    let description: String
    let icon: String?
  }

  let name: String
  let main: Main
  let weather: [WeatherItem]
}

@Observable
final class WeatherService {
  var weather: Weather?
  var isLoading = false
  var errorMessage: String?

  private var cancellables = Set<AnyCancellable>()

  func fetchWeather() {
    isLoading = true
    errorMessage = nil

    // 공백 제거
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    // 섭씨 사용을 위해 units=metric 추가, 필요 시 언어(lang)도 설정 가능
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=\(apiKey)&units=metric&lang=kr")!

    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: OpenWeatherResponse.self, decoder: JSONDecoder())
      .map { response in
        Weather(
          city: response.name,
          temperature: Int(round(response.main.temp)),
          description: response.weather.first?.description ?? ""
        )
      }
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        if case let .failure(error) = completion {
          self?.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] weather in
        self?.weather = weather
      }
      .store(in: &cancellables)
  }
}
