//
//  TodoViewModel.swift
//  ImmutableTodo
//
//  Created by Jungman Bae on 10/30/25.
//

import SwiftUI

@MainActor
@Observable
final class TodoViewModel {
  private let store: TodoStore

  var todos: [Todo] = []

  var newTodoTitle: String = ""
  var showingAddSheet = false

  init(store: TodoStore = TodoStore()) {
    self.store = store
  }

  // Create
  func addTodo() async {
    guard !newTodoTitle.isEmpty else { return }

    let todo = Todo(title: newTodoTitle)
    await store.add(todo)
    newTodoTitle = ""
    await loadTodos()
  }

  // Read: Todo list 가져오기 (list)
  func loadTodos() async {
    todos = await store.getAll()
  }

  // Update
  func updateTodoTitle(_ todo: Todo, newTitle: String) async {
    let updatedTodo = todo.withTitle(newTitle)
    await store.update(updatedTodo)
    await loadTodos()
  }

  func toggleTodoCompletion(_ todo: Todo) async {
    let updatedTodo = todo.withCompleted(!todo.isCompleted)
    await store.update(updatedTodo)
    await loadTodos()
  }

  // Delete
  func deleteTodo(_ todo: Todo) async {
    await store.delete(id: todo.id)
    await loadTodos()
  }

  var completedTodos: [Todo] {
    todos.filter { $0.isCompleted }
  }

  var activeTodos: [Todo] {
    todos.filter { !$0.isCompleted }
  }

}
