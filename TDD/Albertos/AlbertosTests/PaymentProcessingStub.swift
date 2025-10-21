
//
//  PaymentProcessingSpy.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/21/25.
//
@testable import Albertos
import Foundation
import Testing
import Combine

class PaymentProcessingStub: PaymentProcessing {
  let result: Result<Void, Error>

  init(returning result: Result<Void, Error>) {
    self.result = result
  }

  func process(order: Albertos.Order) -> AnyPublisher<Void, Error> {
    return result.publisher
      .delay(for: 0.01, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
