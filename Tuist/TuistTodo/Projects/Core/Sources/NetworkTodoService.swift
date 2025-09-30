//
//  NetworkTodoService.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//

import Foundation
import Combine

public enum NetworkError: Error {
  case invalidURL
  case invalidResponse(statusCode: Int)
  case noData
  case decodingError(Error)
  case underlying(Error)
}

public class NetworkTodoService {
  private let baseURL = URL(string: "http://127.0.0.1:5001/est-ios04/us-central1/")!
  private var cancellables = Set<AnyCancellable>()

  public init() {
    
  }

  // 페이지 파라미터 추가
  public func fetchTodos(page: Int = 1) -> AnyPublisher<TodoResponse, Error> {
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

  public func createTodo(title: String) -> AnyPublisher<TodoItem, NetworkError> {
    let url = baseURL.appending(path: "createTodo")

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    let body = TitleRequest(title: title)
    do {
      let encoder = JSONEncoder()
      request.httpBody = try encoder.encode(body)
    } catch {
      return Fail(error: .underlying(error)).eraseToAnyPublisher()
    }

    return URLSession.shared
      .dataTaskPublisher(for: request)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw NetworkError.noData
        }
        if !(200...299).contains(httpResponse.statusCode) {
          throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        return data
      }
      .decode(type: TodoItem.self, decoder: JSONDecoder())
      .mapError { error in
        switch error {
        case let decodingError as DecodingError:
          return .decodingError(decodingError)
        case let urlError as URLError:
          return .underlying(urlError)
        case let netErr as NetworkError:
          return netErr
        default:
          return .underlying(error)
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  public func updateTodo(item: TodoItem) -> AnyPublisher<TodoItem, NetworkError> {
    let components = URLComponents(
      url: baseURL.appending(components: "updateTodo", item.id),
      resolvingAgainstBaseURL: false
    )!

    let url = components.url!

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")

    do {
      let encoder = JSONEncoder()
      request.httpBody = try encoder.encode(item)
    } catch {
      return Fail(error: .underlying(error)).eraseToAnyPublisher()
    }

    return URLSession.shared
      .dataTaskPublisher(for: request)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw NetworkError.noData
        }
        if !(200...299).contains(httpResponse.statusCode) {
          throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        return data
      }
      .decode(type: TodoItem.self, decoder: JSONDecoder())
      .mapError { error in
        switch error {
        case let decodingError as DecodingError:
          return .decodingError(decodingError)
        case let urlError as URLError:
          return .underlying(urlError)
        case let netErr as NetworkError:
          return netErr
        default:
          return .underlying(error)
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  public func deleteTodo(id: String) -> AnyPublisher<DeleteResponse, NetworkError>  {
    let components = URLComponents(
      url: baseURL.appending(components: "deleteTodo", id),
      resolvingAgainstBaseURL: false
    )!

    let url = components.url!

    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"

    return URLSession.shared
      .dataTaskPublisher(for: request)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .tryMap { data, response -> Data in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw NetworkError.noData
        }
        if !(200...299).contains(httpResponse.statusCode) {
          throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        return data
      }
      .decode(type: DeleteResponse.self, decoder: JSONDecoder())
      .mapError { error in
        switch error {
        case let decodingError as DecodingError:
          return .decodingError(decodingError)
        case let urlError as URLError:
          return .underlying(urlError)
        case let netErr as NetworkError:
          return netErr
        default:
          return .underlying(error)
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
