//
//  PaymentProcessing.swift
//  Albertos
//
//  Created by Jungman Bae on 10/21/25.
//
import Combine

protocol PaymentProcessing {
  func process(order: Order) -> AnyPublisher<Void, Error>
}
