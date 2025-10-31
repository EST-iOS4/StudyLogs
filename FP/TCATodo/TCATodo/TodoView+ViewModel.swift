//
//  Todo+ViewModel.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation
import Combine

extension TodoView {
  @MainActor
  @Observable
  class ViewModel {
    private let store: TodoStore
    private var cancellables = Set<AnyCancellable>();

    var todos: [Todo] = []
    var newTodoText: String = ""

    init(store: TodoStore) {
      self.store = store

      store.$state
        .map(\.todos)
        .assign(to: \.todos, on: self)
        .store(in: &cancellables)
    }

    func loadTodo() {
      store.send(.loadTodos)
    }

    func addTodo() {
      store.send(.addTodo(newTodoText))
      newTodoText = ""
    }

  }
}
