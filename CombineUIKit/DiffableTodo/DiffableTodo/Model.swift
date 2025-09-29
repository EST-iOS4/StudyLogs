//
//  Model.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//

import Foundation

nonisolated enum Section: CaseIterable {
  case todo
  case completed
}

nonisolated struct TodoItem: Hashable, Identifiable {
  let id = UUID()
  var title: String
  var isCompleted: Bool = false

  init(title: String) {
    self.title = title
  }
}
