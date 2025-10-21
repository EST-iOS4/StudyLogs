//
//  Order+HippoPayments.swift
//  Albertos
//
//  Created by Jungman Bae on 10/21/25.
//

extension Order {
  var hippoPaymentsPayload: [String: Any] {
    [
      "items": items.map { $0.name }
    ]
  }
}

