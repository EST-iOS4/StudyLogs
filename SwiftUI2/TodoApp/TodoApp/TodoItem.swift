//
//  Item.swift
//  TodoApp
//
//  Created by Jungman Bae on 8/8/25.
//

import Foundation
import SwiftData
import SwiftUICore

@Model
final class TodoItem {
  var title: String
  var isComplted: Bool
  var priority: Priority
  var createdAt: Date
  var dueDate: Date?
  var notes: String?
  var category: Category?

  enum Priority: Int, Codable, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2

    var name: String {
      switch self {
      case .low:
        return "낮음"
      case .medium:
        return "중간"
      case .high:
        return "높음"
      }
    }

    var color: Color {
      switch self {
      case .low:
        return Color.green
      case .medium:
        return Color.yellow
      case .high:
        return Color.red
      }
    }
  }

  init(title: String, priority: Priority = .medium) {
    self.title = title
    self.isComplted = false
    self.priority = priority
    self.createdAt = Date()
  }
}
