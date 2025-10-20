//
//  MenuItemDetail.ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation
import Combine

extension MenuItemDetail {
  class ViewModel: ObservableObject {
    let item: MenuItem
    @Published private(set) var addOrRemoveFromOrderButtonText = "Remove from order"
    private var cancellables = Set<AnyCancellable>()

    private let orderController: OrderController

    init(
      item: MenuItem,
      orderController: OrderController) {
        self.item = item
      self.orderController = orderController
        self.orderController.$order
          .sink { [weak self] order in
            guard let self else { return }
            if (order.items.contains { $0 == self.item }) {
              self.addOrRemoveFromOrderButtonText =  "Remove from order"
            } else {
              self.addOrRemoveFromOrderButtonText = "Add to order"
            }
          }
          .store(in: &cancellables)
    }
  }
}
