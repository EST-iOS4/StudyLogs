//
//  OpenMeteoResponse.swift
//  Weather
//
//  Created by Jungman Bae on 9/22/25.
//

import Foundation

struct OpenMeteoResponse: Decodable {
  struct Current: Decodable {
    let temperature: Double
    let windSpeed: Double
    let weatherCode: Int
  }
  let current_weather: Current
}
