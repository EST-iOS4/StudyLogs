//
//  OrderButton.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import SwiftUI
import Combine

struct OrderButton: View {
  @ObservedObject private var viewModel: ViewModel

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    Button(action: {
      // TODO: 구현 필요
    }) {
      Text(viewModel.buttonText)
    }
  }
}

extension OrderButton {
  class ViewModel: ObservableObject {
    @Published private(set) var buttonText = "Your Order"
    private let orderController: OrderController
    private var cancellables = Set<AnyCancellable>()

    init(orderController: OrderController) {
      self.orderController = orderController
      setupSubscriptions()
    }

    private func setupSubscriptions() {
      orderController.$order
        .sink { [weak self] order in
          self?.updateButtonText(for: order)
        }
        .store(in: &cancellables)
    }

    private func updateButtonText(for order: Order) {
      if order.items.isEmpty {
        buttonText = "Your Order"
      } else {
        buttonText = "Your Order \(order.total.formatted(.currency(code: "USD")))"
      }
    }
  }
}
