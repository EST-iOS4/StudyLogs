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
    
    if !results.isEmpty {
      if callCount < results.count {
        resultToReturn = results[callCount]
        callCount += 1
      } else {
        resultToReturn = results.last!
      }
    } else {
      resultToReturn = result
    }
    
    return resultToReturn.publisher
      .delay(for: 0.01, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }

}
