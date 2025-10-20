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
  @State var showOrder = false

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    Button(action: {
      showOrder.toggle()
    }) {
      Text(viewModel.buttonText)
    }
    .sheet(isPresented: $showOrder) {
      NavigationView {
        OrderDetail(viewModel: .init(orderController: viewModel.orderController))
      }
    }
  }
}

extension OrderButton {
  class ViewModel: ObservableObject {
    @Published private(set) var buttonText = "Your Order"
    let orderController: OrderController
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
