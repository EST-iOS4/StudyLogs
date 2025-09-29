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

  private let todosSubject = CurrentValueSubject<[TodoItem], Never>([])

  var todos: AnyPublisher<[TodoItem], Never> {
    todosSubject.eraseToAnyPublisher()
  }

  func startRealtimeSync() {
    Timer.publish(every: 5.0, on: .main, in: .common)
      .autoconnect()
      .flatMap { _ in self.fetchTodos() }
      .sink(receiveCompletion: { completion in
        if case .failure(let error) = completion {
          print("동기화 오류: \(error)")
        }
      },
            receiveValue: { [weak self] todos in
        self?.todosSubject.send(todos)
      })
      .store(in: &cancellables)
  }

  private func fetchTodos() -> AnyPublisher<[TodoItem], Error> {
    URLSession.shared
      .dataTaskPublisher(for: baseURL.appendingPathComponent("getTodos"))
      .map(\.data)
      .decode(type: TodoResponse.self, decoder: JSONDecoder())
      .map(\.todos)
      .eraseToAnyPublisher()
  }
}
