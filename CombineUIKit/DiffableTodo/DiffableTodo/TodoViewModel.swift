//
//  TodoViewModel.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//
import Combine

final class TodoViewModel {
  @Published private(set) var todos: [TodoItem] = []

  var todosPublisher: AnyPublisher<[TodoItem], Never> {
    $todos.eraseToAnyPublisher()
  }

  func addTodo(_ title: String) {
    todos.append(TodoItem(title: title))
  }

  func toggleTodo(id: TodoItem.ID) {
    guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
    todos[index].isCompleted.toggle()
  }

}
