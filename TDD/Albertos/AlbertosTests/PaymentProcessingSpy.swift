//
//  PaymentProcessingSpy.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/21/25.
//
@testable import Albertos
import Testing
import Combine

class PaymentProcessingSpy: PaymentProcessing {
  private(set) var receivedOrder: Order?

  func process(order: Albertos.Order) -> AnyPublisher<Void, any Error> {
    receivedOrder = order
    return Result<Void, Error>.success(())
      .publisher
      .eraseToAnyPublisher()
  }
}
