//
//  OrderDetail+ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation
import Combine
import HippoPayments

extension OrderDetail {
  class ViewModel: ObservableObject {
    private let paymentProcessor: HippoPaymentsProcessor
    
    @Published private(set) var orderItems: [MenuItem] = []
    @Published private(set) var orderTotal: Double = 0.0
    private let orderController: OrderController
    private var cancellables = Set<AnyCancellable>()

    init(orderController: OrderController,
         paymentProcessor: HippoPaymentsProcessor) {
      self.orderController = orderController
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


  }
}
