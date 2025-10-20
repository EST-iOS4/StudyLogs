//
//  MenuItem+JSONFixture.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/17/25.
//
@testable import Albertos

extension MenuItem {
  static func jsonFixture(
    name: String = "a name",
    description: String = "a description",
    category: String = "a category",
    price: Double = 10.0,
    spicy: Bool = false
  ) -> String {
    return """
      {
        "name": "\(name)",
        "description": "\(description)",
        "category": "\(category)",
        "price": \(price),
        "spicy": \(spicy)
      }
      """
  }
}
