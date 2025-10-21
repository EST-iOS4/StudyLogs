//
//  OrderDetail+ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation
import Combine
import HippoPayments
import SwiftUI

extension OrderDetail {
  class ViewModel: ObservableObject {
    private let paymentProcessor: PaymentProcessing
    let onAlertDismiss: () -> Void

    @Published private(set) var orderItems: [MenuItem] = []
    @Published private(set) var orderTotal: Double = 0.0
    @Published var alertToShow: Alert.ViewModel?
    private let orderController: OrderController
    private var cancellables = Set<AnyCancellable>()

    init(orderController: OrderController,
         onAlertDismiss: @escaping () -> Void,
         paymentProcessor: PaymentProcessing = HippoPaymentsProcessor(apiKey: "A1B2C3")) {
      self.orderController = orderController
      self.onAlertDismiss = onAlertDismiss
      self.paymentProcessor = paymentProcessor
      setupSubscriptions()
    }

    private func setupSubscriptions() {
      orderController.$order
        .sink { [weak self] order in
          self?.updateOrderDetails(for: order)
        }
        .store(in: &cancellables)
    }

    private func updateOrderDetails(for order: Order) {
      orderItems = order.items
      orderTotal = order.total
    }

    func checkout() {
      paymentProcessor.process(order: orderController.order)
        .sink(receiveCompletion: { [weak self] completion in
          guard case .failure = completion else { return }
          self?.alertToShow = Alert.ViewModel(
            title: "실패",
            message: "There's been an error with your order. Please contact a waiter.",
            buttonText: "OK",
            buttonAction: self?.onAlertDismiss
          )
        }, receiveValue: { [weak self] _ in
          self?.alertToShow = Alert.ViewModel(
            title: "성공",
            message: "The payment was successful. Your food will be with you shortly.",
            buttonText: "OK",
            buttonAction: {
              self?.orderController.resetOrder()
              self?.onAlertDismiss()
            }
          )
        })
        .store(in: &cancellables)
    }

  }
}
