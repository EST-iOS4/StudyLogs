//
//  MenuItemDetail.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import SwiftUI

struct MenuItemDetail: View {
  @ObservedObject private(set) var viewModel: ViewModel

  var body: some View {
    VStack {
      Text(viewModel.item.name)
        .font(.title)

      Text(viewModel.item.description ?? "")
        .padding()

      Text("Price: $\(viewModel.item.price, specifier: "%.2f")")
        .font(.headline)

      Button(viewModel.addOrRemoveFromOrderButtonText) {
        viewModel.addOrRemoveFromOrder()
      }
      .padding()
      .background(Color.blue)
      .foregroundColor(.white)
      .cornerRadius(10)
    }
    .padding()
  }
}
