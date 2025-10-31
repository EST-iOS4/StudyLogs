//
//  AddTodoView.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import SwiftUI

struct AddTodoView: View {
  @Binding var viewModel: TodoView.ViewModel

  var body: some View {
    HStack {
      TextField("Add todo", text: $viewModel.newTodoText)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onSubmit {
          viewModel.addTodo()
        }

      Button("Add") {
        viewModel.addTodo()
      }
      .disabled(viewModel.newTodoText.isEmpty)
    }
    .padding()
  }
}
