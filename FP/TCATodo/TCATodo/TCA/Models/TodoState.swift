//
//  TodoState.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

nonisolated struct TodoState: Equatable {
  var todos: [Todo] = []
  var filter: Filter = .all

  var filteredTodos: [Todo] {
    switch filter {
    case .all:
      return todos
    case .active:
      return todos.filter { !$0.isCompleted }
    case .completed:
      return todos.filter { $0.isCompleted }
    }
  }

  enum Filter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
  }
}
