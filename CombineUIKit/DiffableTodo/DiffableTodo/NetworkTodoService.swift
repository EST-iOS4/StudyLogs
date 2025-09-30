//
//  NetworkTodoService.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//

import Foundation
import Combine

class NetworkTodoService {
  private let baseURL = URL(string: "http://127.0.0.1:5001/est-ios04/us-central1/")!
  private var cancellables = Set<AnyCancellable>()

  // 페이지 파라미터 추가
  func fetchTodos(page: Int = 1) -> AnyPublisher<TodoResponse, Error> {
    var components = URLComponents(url: baseURL.appendingPathComponent("getTodos"), resolvingAgainstBaseURL: false)!
    components.queryItems = [
      URLQueryItem(name: "page", value: String(page))
    ]

    let url = components.url!

    return URLSession.shared
      .dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: TodoResponse.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }

  func createTodo(title: String) -> AnyPublisher<TodoItem, Error> {
    return Just(TodoItem(title: title))
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func updateTodo(item: TodoItem) -> AnyPublisher<TodoItem, Error> {
    return Just(item)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func deleteTodo(id: String) -> AnyPublisher<String,Error>  {
    return Just("삭제완료")
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
