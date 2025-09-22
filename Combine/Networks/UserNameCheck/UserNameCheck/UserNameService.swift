//
//  UserNameService.swift
//  UserNameCheck
//
//  Created by Jungman Bae on 9/22/25.
//

import Foundation
import Combine

class UserNameService: ObservableObject {
  private var cancellables = Set<AnyCancellable>()
  private let baseURL = "http://127.0.0.1:8080"

  // MARK: - Combine 방식
  func checkUserNameAvailability(userName: String) -> AnyPublisher<UserNameResponse, APIError> {
    guard !userName.isEmpty else {
      return Fail(error: APIError.invalidURL)
        .eraseToAnyPublisher()
    }

    guard let url = URL(string: "\(baseURL)/isUserNameAvailable?userName=\(userName)") else {
      return Fail(error: APIError.invalidURL)
        .eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: UserNameResponse.self, decoder: JSONDecoder())
      .mapError { error in
        if error is DecodingError {
          return APIError.decodingError
        } else {
          return APIError.networkError(error)
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
