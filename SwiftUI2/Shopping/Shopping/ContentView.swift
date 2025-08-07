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
  @StateObject private var cart = ShoppingCartViewModel()
  @State private var showingCart = false

  var body: some View {
    NavigationStack {
      List(cart.products) { product in
        // TODO: Product Row 뷰 구현
        ProductRow(product: product)
          .environmentObject(cart)
      }
      .navigationTitle("상품 목록")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            showingCart = true
          }) {
            Label("장바구니", systemImage: "cart")
          }
        }
      }
      .sheet(isPresented: $showingCart) {
        CartView(cart: cart)
      }
    }
  }
}

struct ProductRow: View {
  let product: Product
  @EnvironmentObject var cart: ShoppingCartViewModel

  var body: some View {
    HStack {
      Text(product.name)
      Spacer()
      Text("$\(product.price, specifier: "%.2f")")
      Button(action: {
        cart.addToCart(product: product)
      }) {
        Image(systemName: "plus.circle")
          .foregroundColor(.blue)
      }
    }
  }
}

struct CartView: View {
  @ObservedObject var cart: ShoppingCartViewModel
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    NavigationStack {
      List {
        ForEach(cart.cartItems) { item in
          HStack {
            Text(item.product.name)
            Spacer()
            Text("\(item.quantity)개")
            Text("$\(item.product.price * Double(item.quantity), specifier: "%.2f")")
          }
        }
        .onDelete(perform: removeItems)
      }
      .navigationTitle("장바구니")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button("닫기") {
            dismiss()
          }
        }
      }
    }
  }

  private func removeItems(at offsets: IndexSet) {
    for index in offsets {
      cart.removeFromCart(item: cart.cartItems[index])
    }
  }
}

#Preview {
  ContentView()
}
