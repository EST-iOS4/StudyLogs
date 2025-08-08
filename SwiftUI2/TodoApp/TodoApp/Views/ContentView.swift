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
        } else {
          Text("할 일이 없습니다. 할 일을 추가해보세요!")
            .foregroundColor(.gray)
            .padding()
            .onTapGesture {
              showingAddTodo = true
            }
        }
      }
      .navigationTitle("할 일 목록")
      .searchable(
        text: $searchText,
//        placement: .navigationBarDrawer(displayMode: .always)
      )
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Picker("우선순위", selection: $selectedPriority) {
            Text("전체").tag(nil as TodoItem.Priority?)
            ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
              Text(priority.name).tag(priority.self as TodoItem.Priority?)
            }
          }
        }

        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            showingAddTodo = true
          }) {
            Label("추가", systemImage: "plus")
          }
        }
      }
    }
    .sheet(isPresented: $showingAddTodo) {
      AddTodoView()
        .environment(\.modelContext, modelContext)
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
