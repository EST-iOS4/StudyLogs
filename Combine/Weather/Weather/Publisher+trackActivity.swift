//
//  Publisher+trackActivity.swift
//  Weather
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation
import Combine

extension Publisher {
  func trackActivity(_ isLoading: CurrentValueSubject<Bool,Never>) -> AnyPublisher<Self.Output, Self.Failure> {
    return handleEvents(
      receiveSubscription: { _ in isLoading.send(true) },
      receiveCompletion: { _ in isLoading.send(false) },
      receiveCancel: { isLoading.send(true) }
    )
    .eraseToAnyPublisher()
  }
}
