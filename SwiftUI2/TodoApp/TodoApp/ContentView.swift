//
//  ContentView.swift
//  TodoApp
//
//  Created by Jungman Bae on 8/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \TodoItem.createdAt, order: .reverse) private var todos: [TodoItem]

  @State private var showingAddTodo = false
  @State private var searchText = ""
  @State private var selectedPriority: TodoItem.Priority?

  var filteredTodos: [TodoItem] {
    todos.filter { todo in
      (searchText.isEmpty || todo.title.localizedCaseInsensitiveContains(searchText)) &&
      (selectedPriority == nil || todo.priority == selectedPriority)
    }
  }

  var body: some View {
    NavigationStack {
      List {
        if !filteredTodos.isEmpty {
          ForEach(filteredTodos) { todo in
            TodoRowView(todo: todo)
          }
          .onDelete(perform: deleteTodos)
        }
      }
      .toolbar {
      }
    }
  }

  func deleteTodos(at offsets: IndexSet) {
    for index in offsets {
      let todo = filteredTodos[index]
      modelContext.delete(todo)
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: TodoItem.self, inMemory: true)
}
