//
//  TodoViewModel.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//
import Combine

final class TodoViewModel {
  @Published private(set) var todos: [TodoItem] = [
    TodoItem(title: "1"),
    TodoItem(title: "2"),
    TodoItem(title: "3"),
    TodoItem(title: "4"),
    TodoItem(title: "5"),
    TodoItem(title: "6"),
    TodoItem(title: "7"),
    TodoItem(title: "8"),
    TodoItem(title: "9"),
    TodoItem(title: "10"),
    TodoItem(title: "11"),
    TodoItem(title: "12"),
    TodoItem(title: "13"),
    TodoItem(title: "14"),
    TodoItem(title: "15"),
    TodoItem(title: "16"),
    TodoItem(title: "17"),
    TodoItem(title: "18"),
    TodoItem(title: "19"),
    TodoItem(title: "20"),
    TodoItem(title: "21"),
    TodoItem(title: "22"),
    TodoItem(title: "23"),
    TodoItem(title: "24"),
    TodoItem(title: "25"),
    TodoItem(title: "26"),
    TodoItem(title: "27"),
    TodoItem(title: "28"),
  ]

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
