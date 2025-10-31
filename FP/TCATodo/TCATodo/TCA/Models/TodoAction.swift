//
//  TodoAction.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

enum TodoAction: Equatable {
  case addTodo(String)
  case toggleTodo(UUID)
  case deleteTodo(UUID)
  case editTodo(UUID, String)
  case setFilter(TodoState.Filter)
  case clearCompleted
  case loadTodos
  case todosLoaded([Todo])
  case saveTodos
}
