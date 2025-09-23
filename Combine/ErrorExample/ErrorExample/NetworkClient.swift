//
//  NetworkClient.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation
import Combine

final class NetworkClient {
  func request(_ url: URL) -> AnyPublisher<Data, APIError> {
    URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { data, response in
        guard let http = response as? HTTPURLResponse else { throw APIError.invalidURL }
        guard (200..<300).contains(http.statusCode) else { throw APIError.serverError(http.statusCode) }
        return data
      }
      .mapError { error in
        print(">> \(error)")
        if let urlError = error as? URLError { return APIError.networkError(urlError) }
        if let api = error as? APIError { return api }
        return APIError.decodingError
      }
      .eraseToAnyPublisher()
  }
}
