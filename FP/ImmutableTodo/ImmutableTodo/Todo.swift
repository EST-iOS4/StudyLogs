//
//  Todo.swift
//  ImmutableTodo
//
//  Created by Jungman Bae on 10/30/25.
//

import Foundation

struct Todo: Sendable, Identifiable {
  let id: UUID
  let title: String
  let isCompleted: Bool

  init(id: UUID = UUID(), title: String, isCompleted: Bool) {
    self.id = id
    self.title = title
    self.isCompleted = isCompleted
  }

  func withCompleted(_ completed: Bool) -> Todo {
    Todo(
      id: id, title: title, isCompleted: completed
    )
  }

  func withTitle(_ newTitle: String) -> Todo {
    Todo(id: id, title: newTitle, isCompleted: isCompleted)
  }
}
