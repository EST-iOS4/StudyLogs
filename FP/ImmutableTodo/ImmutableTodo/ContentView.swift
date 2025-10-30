//
//  ContentView.swift
//  ImmutableTodo
//
//  Created by Jungman Bae on 10/30/25.
//

import SwiftUI

struct ContentView: View {
  @State private var viewModel = TodoViewModel()

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        List {
          ForEach(viewModel.todos) { todo in
            Button {
              Task {
                await viewModel.toggleTodoCompletion(todo)
              }
            } label: {
              HStack {
                Image(systemName: todo.isCompleted ? "checkmark.app" : "square")
                Text(todo.title)
              }
            }
            // TodoRow
          }
        }
      }
      .navigationTitle("Todos")
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
//            viewModel.showingAddSheet = true
            Task {
              viewModel.newTodoTitle = "Todo Item \(viewModel.todos.count + 1)"
              await viewModel.addTodo()
            }
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $viewModel.showingAddSheet) {
        // AddTodoView
      }
    }
  }
}

#Preview {
  ContentView()
}
