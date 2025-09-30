//
//  Model.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//

import Foundation

public enum Section: CaseIterable {
  case todo
  case completed
  case next
}

public struct TodoItem: Hashable, Identifiable, Codable {
  public var id: String
  public var title: String
  public var isCompleted: Bool = false

  public init(title: String) {
    self.id = UUID().uuidString
    self.title = title
  }

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case isCompleted = "completed"
  }
}

public struct TodoResponse: Codable {
  public struct Pagination: Codable {
    public var totalPages: Int
    public var currentPage: Int
    public var hasNext: Bool

    public init(totalPages: Int, currentPage: Int, hasNext: Bool) {
      self.totalPages = totalPages
      self.currentPage = currentPage
      self.hasNext = hasNext
    }
  }

  public var todos: [TodoItem]
  public var pagination: Pagination

  public init(todos: [TodoItem], pagination: Pagination) {
    self.todos = todos
    self.pagination = pagination
  }
}

struct TitleRequest: Encodable {
  let title: String
}

public struct DeleteResponse: Codable {
  public var id: String?
  public var message: String?
  public var error: String?

  public init(id: String? = nil, message: String? = nil, error: String? = nil) {
    self.id = id
    self.message = message
    self.error = error
  }
}
