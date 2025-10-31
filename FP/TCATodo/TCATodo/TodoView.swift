//
//  ContentView.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import SwiftUI

struct TodoView: View {
  @State private var viewModel: ViewModel = .init(store: Store.todoStore())

  var body: some View {
    NavigationView {
      VStack {
        // 입력 필드
        AddTodoView(viewModel: $viewModel)

        // 필터
        FilterView(viewModel: $viewModel)

        // Todo 리스트
        List {
          ForEach(viewModel.todos) { todo in
            TodoRowView(
              todo: todo
            )
          }
          .onDelete { indexSet in
            indexSet.forEach { index in
              //              let todo = viewStore.filteredTodos[index]
              //              viewStore.send(.deleteTodo(todo.id))
            }
          }
        }

        // 하단 버튼
        if !viewModel.todos.filter({ $0.isCompleted }).isEmpty {
          Button("Clear Completed") {
            //            viewStore.send(.clearCompleted)
          }
          .padding()
        }
      }
      .navigationTitle("Todos")
      .onAppear {
        viewModel.loadTodo()
      }
    }
  }
}


struct TodoRowView: View {
  let todo: Todo
  @State private var isEditing = false
  @State private var editText = ""

  var body: some View {
    HStack {
      Button(action: {
        //        viewStore.send(.toggleTodo(todo.id))
      }) {
        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
          .foregroundColor(todo.isCompleted ? .green : .gray)
      }

      if isEditing {
        TextField("", text: $editText, onCommit: {
          //          viewStore.send(.editTodo(todo.id, editText))
          isEditing = false
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
      } else {
        Text(todo.title)
          .strikethrough(todo.isCompleted)
          .foregroundColor(todo.isCompleted ? .gray : .primary)
          .onTapGesture(count: 2) {
            editText = todo.title
            isEditing = true
          }
      }
    }
  }
}


#Preview {
  TodoView()
}
