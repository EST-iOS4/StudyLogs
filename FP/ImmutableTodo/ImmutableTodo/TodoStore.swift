//
//  TodoStore.swift
//  ImmutableTodo
//
//  Created by Jungman Bae on 10/30/25.
//

import Foundation

actor TodoStore: Sendable {
  private var todos: [Todo] = []

  func add(_ todo: Todo) {
    todos.append(todo)
  }

  func update(_ todo: Todo) {
    if let index = todos.firstIndex(where: { $0.id == todo.id }) {
      todos[index] = todo
    }
  }

  func delete(id: UUID) {
    todos.removeAll { $0.id == id }
  }

  func getAll() -> [Todo] {
    return todos
  }

  func getCompleted() -> [Todo] {
    return todos.filter { $0.isCompleted }
  }
}
