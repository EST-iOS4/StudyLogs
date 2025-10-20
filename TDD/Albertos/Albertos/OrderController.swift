//
//  OrderController.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation
import Combine

class OrderController: ObservableObject {
  @Published private(set) var order: Order

  init(order: Order = Order(items: [])) {
    self.order = order
  }

  func isItemInOrder(_ item: MenuItem) -> Bool {
    // TODO: 구현 필요
    return false
  }

  func addToOrder(item: MenuItem) {
    // TODO: 구현 필요
  }

  func remoteFromOrder(item: MenuItem) {
    // TODO: 구현 필요
  }
}
