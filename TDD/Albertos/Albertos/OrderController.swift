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
    return order.items.contains { $0 == item }
  }

  func addToOrder(item: MenuItem) {
    order.items.append(item)
  }

  func remoteFromOrder(item: MenuItem) {
    order.items.removeAll(where: { $0 == item })
  }
}
