//
//  MenuItem.swift
//  Albertos
//
//  Created by Jungman Bae on 10/17/25.
//

nonisolated struct MenuItem {
  let category: String
  let name: String
  let spicy: Bool
}

extension MenuItem: Identifiable {
  var id: String { name }
}

extension MenuItem: Equatable {}
extension MenuItem: Decodable {}
