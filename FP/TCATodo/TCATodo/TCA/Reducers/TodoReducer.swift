//
//  TodoReducer.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

typealias TodoStore = Store<TodoState, TodoAction, TodoEnvironment>

let todoReducer = { (
  state: inout TodoState,
  action: TodoAction,
  environment: TodoEnvironment
) -> Effect<TodoAction> in
  switch action {
  case .addTodo(let title):
    guard !title.isEmpty else { return .none }

    let todo = Todo(title: title)
    state.todos.append(todo)

    return environment.saveTodos(Array(state.todos))
  case .toggleTodo(let id):
    guard let index = state.todos.firstIndex(where: {$0.id == id})
    else { return .none }

    state.todos[index].isCompleted.toggle()
    return environment.saveTodos(Array(state.todos))
  case .deleteTodo(let id):
    guard let index = state.todos.firstIndex(where: {$0.id == id})
    else { return .none }

    state.todos.removeAll(where: { $0.id == id })

    return environment.saveTodos(Array(state.todos))

  case .editTodo(let id, let newTitle):
    guard let index = state.todos.firstIndex(where: {$0.id == id})
    else { return .none }

    state.todos[index].title = newTitle

    return environment.saveTodos(Array(state.todos))

  case .setFilter(let filter):
    state.filter = filter
    return .none

  case .clearCompleted:
    state.todos.removeAll { $0.isCompleted }
    return environment.saveTodos(Array(state.todos))
  case .loadTodos:
    return environment.loadTodos()
  case .todosLoaded(let todos):
    state.todos = todos
    return .none
  case .saveTodos:
    return environment.saveTodos(Array(state.todos))
  }
}
