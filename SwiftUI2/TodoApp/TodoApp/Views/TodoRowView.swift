//
//  TodoRowView.swift
//  TodoApp
//
//  Created by Jungman Bae on 8/8/25.
//

import SwiftUI

struct TodoRowView: View {
  @Bindable var todo: TodoItem

  var body: some View {
    HStack {
      Button {
        withAnimation {
          todo.isComplted.toggle()
        }
      } label: {
        Image(systemName: todo.isComplted ? "checkmark.circle.fill" : "circle")
          .foregroundStyle(todo.isComplted ? .green : .gray)
          .font(.title2)
      }
      .buttonStyle(.plain)
      VStack(alignment: .leading, spacing: 4) {
        Text(todo.title)
          .strikethrough(todo.isComplted)
          .foregroundStyle(todo.isComplted ? .secondary : .primary)

        HStack {
          Label(todo.priority.name, systemImage: "flag.fill")
            .font(.caption)
            .foregroundStyle(todo.priority.color)

          if let dueDate = todo.dueDate {
            Label(formatDate(dueDate), systemImage: "calendar")
              .font(.caption)
              .foregroundStyle(dueDate < Date() && !todo.isComplted ? .red : .secondary)
          }

          if let category = todo.category {
            Label(category.name, systemImage: "folder")
              .font(.caption)
              .foregroundStyle(Color(category.color))
          }
        }
      }
    }
  }

  func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter.string(from: date)
  }
}
