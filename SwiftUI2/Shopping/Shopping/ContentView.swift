//
//  ContentView.swift
//  Shopping
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

// 제품 모델
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

// 장바구니 모델
struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}

// 뷰모델
class ShoppingCartViewModel: ObservableObject {
    @Published var products = [
        Product(name: "Apple", price: 1.0),
        Product(name: "Banana", price: 0.5),
        Product(name: "Orange", price: 0.75)
    ]

    @Published var cartItems: [CartItem] = []

    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }

    func removeFromCart(item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems.remove(at: index)
        }
    }
}

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
