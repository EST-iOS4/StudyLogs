//
//  Todo.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

struct Todo: Equatable, Identifiable, Codable {
  let id: UUID
  var title: String
  var isCompleted: Bool

  init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
  }
}
