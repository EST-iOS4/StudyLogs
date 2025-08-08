//
//  AddTodoView.swift
//  TodoApp
//
//  Created by Jungman Bae on 8/8/25.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss

  @State private var title: String = ""
  @State private var priority = TodoItem.Priority.medium
  @State private var dueDate = Date()
  @State private var hasDueDate = false
  @State private var notes = ""
  @State private var selectedCategory: Category?

  @Query private var categories: [Category]

  var body: some View {
    NavigationStack {
      Form {
        Section("기본 정보") {
          TextField("할 일 제목", text: $title)
            .textInputAutocapitalization(.words)
            .autocorrectionDisabled(true)

          Picker("우선순위", selection: $priority) {
            ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
              Text(priority.name).tag(priority)
            }
          }
        }

        Section("추가 정보") {
          Toggle("마감일 설정", isOn: $hasDueDate)

          if hasDueDate {
            DatePicker("마감일", selection: $dueDate, displayedComponents: .date)
              .datePickerStyle(.compact)
          }

          if categories.isEmpty {
            Text("카테고리를 먼저 추가해주세요.")
              .foregroundColor(.gray)
          } else {
            Picker("카테고리", selection: $selectedCategory) {
              Text("없음").tag(nil as Category?)
              ForEach(categories) { category in
                Text(category.name).tag(category as Category?)
              }
            }
          }

          TextField("메모", text: $notes)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.none)
            .lineLimit(3...6)
        }
      }
      .navigationTitle("할 일 추가")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("취소") {
            dismiss()
          }
        }

        ToolbarItem(placement: .confirmationAction) {
          Button("저장") {
            addTodo()
          }
          .disabled(title.isEmpty)
        }
      }
    }
  }

  private func addTodo() {
    let todo = TodoItem(title: title, priority: priority)
    todo.dueDate = hasDueDate ? dueDate : nil
    todo.notes = notes
    todo.category = selectedCategory

    modelContext.insert(todo)

    dismiss()
  }
}

#Preview {
  AddTodoView()
}
