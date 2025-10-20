//
//  NetworkFetchingStub.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/20/25.
//
@testable import Albertos
import Foundation
import Combine

class NetworkFetchingStub: NetworkFetching {
  private let result: Result<Data, URLError>

  init(returning: Result<Data, URLError>) {
    self.result = returning
  }

  func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
    return result.publisher
      .delay(for: 0.01, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }

}
