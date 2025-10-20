//
//  Order.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation

struct Order {
  let items: [MenuItem]
  var total: Double {
    0
//    items.reduce(0) { $0 + $1.price }
  }
}
