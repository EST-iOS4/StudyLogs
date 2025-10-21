//
//  OrderDetail.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import SwiftUI

struct OrderDetail: View {
  @Environment(\.dismiss) var dismiss
  @Binding private(set) var isPresented: Bool
  @ObservedObject private var viewModel: ViewModel
  
  init(viewModel: ViewModel, isPresented: Binding<Bool>) {
    self.viewModel = viewModel
    self._isPresented = isPresented
  }
  
  var body: some View {
    List {
      ForEach(viewModel.orderItems) { item in
        HStack {
          VStack(alignment: .leading) {
            Text(item.name)
              .font(.headline)
            Text(item.description ?? "")
              .font(.caption)
              .foregroundColor(.secondary)
          }
          Spacer()
          Text("$\(item.price, specifier: "%.2f")")
            .fontWeight(.medium)
        }
        .padding(.vertical, 4)
      }
      //      .onDelete(perform: viewModel.deleteItems)
      
      if !viewModel.orderItems.isEmpty {
        HStack {
          Text("Total")
            .font(.title2)
            .fontWeight(.bold)
          Spacer()
          Text("$\(viewModel.orderTotal, specifier: "%.2f")")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.blue)
        }
        .padding(.top, 10)
      }
    }
    .navigationTitle("Your Order")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarItems(
      leading: Button("Cancel") {
//        dismiss()
        isPresented.toggle()
      },
      trailing: Button("Checkout") {
        viewModel.checkout()
      }
        .disabled(viewModel.orderItems.isEmpty)
    )
    .alert(item: $viewModel.alertToShow) { alertViewModel in
      Alert(
        title: Text(alertViewModel.title),
        message: Text(alertViewModel.message),
        dismissButton: .default(Text(alertViewModel.buttonText),
                                action: alertViewModel.buttonAction)
      )
    }
  }
}
