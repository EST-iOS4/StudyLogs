//
//  AlbertosApp.swift
//  Albertos
//
//  Created by Jungman Bae on 10/14/25.
//

import SwiftUI

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
  return Dictionary(grouping: menu, by: { $0.category })
    .map { key, value in
      MenuSection(category: key, items: value)
    }
    .sorted { $0.category > $1.category }
}

@main
struct AlbertosApp: App {
  let orderController = OrderController()

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        MenuList(viewModel: .init(menuFetching: MenuFetcher()))
          .navigationTitle("Alberto's 🍕")
      }
      .environmentObject(orderController)
    }
  }
}
