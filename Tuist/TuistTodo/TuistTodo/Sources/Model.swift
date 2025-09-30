//
//  Model.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//

import Foundation

nonisolated enum Section: CaseIterable {
  case todo
  case completed
  case next
}

nonisolated struct TodoItem: Hashable, Identifiable, Codable {
  var id: String
  var title: String
  var isCompleted: Bool = false

  init(title: String) {
    self.id = UUID().uuidString
    self.title = title
  }

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case isCompleted = "completed"
  }
}

nonisolated struct TodoResponse: Codable {
  struct Pagination: Codable {
    var totalPages: Int
    var currentPage: Int
    var hasNext: Bool
  }
  var todos: [TodoItem]
  var pagination: Pagination
}

struct TitleRequest: Encodable {
  let title: String
}

struct DeleteResponse: Codable {
  var id: String?
  var message: String?
  var error: String?
}
