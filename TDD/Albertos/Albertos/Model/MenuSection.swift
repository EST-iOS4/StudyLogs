//
//  MenuSection.swift
//  Albertos
//
//  Created by Jungman Bae on 10/17/25.
//


nonisolated struct MenuSection {
  let category: String
  let items: [MenuItem]
}

extension MenuSection: Identifiable {
  var id: String { category }
}

extension MenuSection: Equatable {}
