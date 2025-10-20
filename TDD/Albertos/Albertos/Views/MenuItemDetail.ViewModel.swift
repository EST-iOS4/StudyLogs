//
//  MenuItemDetail.ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation

extension MenuItemDetail {
  struct ViewModel {
    let item: MenuItem
    let addOrRemoveFromOrderButtonText = "Remove from Order"
    private let orderController: OrderController

    init(
      item: MenuItem,
      orderController: OrderController) {
        self.item = item
      self.orderController = orderController
    }
  }
}
