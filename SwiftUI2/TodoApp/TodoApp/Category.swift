//
//  Category.swift
//  TodoApp
//
//  Created by Jungman Bae on 8/8/25.
//

import Foundation
import SwiftData

@Model
class Category {
  var name: String
  var color: String
  @Relationship(deleteRule: .cascade) var items: [TodoItem]?

  init(name: String, color: String = "blue") {
    self.name = name
    self.color = color
  }
}
