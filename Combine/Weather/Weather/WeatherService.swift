//
//  WeatherService.swift
//  Weather
//
//  Created by Jungman Bae on 9/22/25.
//

import Foundation
import Combine

func describeWeather(code: Int) -> String {
  switch code {
  case 0: return "맑음"
  case 1, 2, 3: return "대체로 맑음/부분 흐림"
  case 45, 48: return "안개"
  case 51, 53, 55: return "이슬비"
  case 61, 63, 65: return "비"
  case 71, 73, 75: return "눈"
  case 80, 81, 82: return "소나기"
  case 95: return "천둥번개"
  case 96, 99: return "우박"
  default: return "알 수 없음"
  }
}

final class WeatherService: ObservableObject {
  @Published var weather: WeatherUI?
  @Published var isLoading = false
  @Published var errorMessage = ""

  private let loadingSubject = CurrentValueSubject<Bool, Never>(false)

  init() {
    loadingSubject.assign(to: &$isLoading)
  }

  private var cancellables = Set<AnyCancellable>()

  private let seoul = (lat: 37.5665, lon: 126.9780, name: "서울")

  private func openMeteoURL(lat: Double, lon: Double) -> URL {
    var comps = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!
    comps.queryItems = [
      .init(name: "latitude", value: String(lat)),
      .init(name: "longitude", value: String(lon)),
      .init(name: "current_weather", value: "true"),
      .init(name: "timezone", value: "Asia/Seoul")
    ]
    return comps.url!
  }

  func fetchSeoul() {
    fetch(lat: seoul.lat, lon: seoul.lon, cityName: seoul.name)
  }

  func fetch(lat: Double, lon: Double, cityName: String) {
    errorMessage = ""

    let url = openMeteoURL(lat: lat, lon: lon)

    URLSession.shared.dataTaskPublisher(for: url)
      .trackActivity(loadingSubject)
      .map(\.data)
      .decode(type: OpenMeteoResponse.self, decoder: JSONDecoder())
      .map { response in
        let currentWeather = response.current_weather
        return WeatherUI(
          city: cityName,
          temperatureC: currentWeather.temperature,
          description: describeWeather(code: currentWeather.weathercode)
        )
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self else { return }
          if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] weather in
          self?.weather = weather
        }
      )
      .store(in: &cancellables)
  }
}
