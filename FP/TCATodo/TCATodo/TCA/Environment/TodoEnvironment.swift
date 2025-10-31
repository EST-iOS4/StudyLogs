//
//  TodoEnvironment.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

struct TodoEnvironment {
  var mainQueue: DispatchQueue
  var saveTodos: ([Todo]) -> Effect<TodoAction>
  var loadTodos: () -> Effect<TodoAction>
}

extension TodoEnvironment {
  static let live = TodoEnvironment(
    mainQueue: .main,
    saveTodos: { todos in
          let data = try? JSONEncoder().encode(todos)
          UserDefaults.standard.set(data, forKey: "todos")
    },
    loadTodos: {
      .task {
        if let data = UserDefaults.standard.data(forKey: "todos"),
           let todos = try? JSONDecoder().decode([Todo].self, from: data) {
          return .todosLoaded(todos)
        } else {
          // TODO: Error Response Action 정의
          // return .loadFailed(errorMessage)
          return .todosLoaded([])
        }
      }
    }
  )
}
