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
  private var results: [Result<Data, URLError>]
  private var callCount = 0

  init(returning: Result<Data, URLError>) {
    self.result = returning
    self.results = []
  }
  
  init(returning results: [Result<Data, URLError>]) {
    self.result = .failure(URLError(.unknown))
    self.results = results
  }

  func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
    let resultToReturn: Result<Data, URLError>
    defer {
      callCount += 1
    }

    if !results.isEmpty {
      guard callCount < results.count else {
        return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
      }
      resultToReturn = results[callCount]
    } else {
      resultToReturn = result
    }
    
    return resultToReturn.publisher
      .delay(for: 0.01, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }

}
