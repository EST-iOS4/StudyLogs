//
//  TodoItem.swift
//  TodoList
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

struct TodoItem {
  var title: String
  var isCompleted: Bool
  var priority: Priority
  
  enum Priority: Int, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2
    
    var color: UIColor {
      switch self {
      case .low: return .systemGreen
      case .medium: return .systemYellow
      case .high: return .systemRed
      }
    }
    
    var title: String {
      switch self {
      case .low: return "낮음"
      case .medium: return "보통"
      case .high: return "높음"
      }
    }
  }
}
