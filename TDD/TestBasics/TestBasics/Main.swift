//
//  Main.swift
//  TestBasics
//
//  Created by Jungman Bae on 10/13/25.
//

import Foundation

func isLeap(_ year: Int) -> Bool {
  return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
}

struct Product {
  let category: String
  let price: Double
}

func sumOf(_ products: [Product], withCategory category: String) -> Double {
  return products.reduce(0.0) {
    guard $1.category == category else { return $0 }
    return $0 + $1.price
  }
}
