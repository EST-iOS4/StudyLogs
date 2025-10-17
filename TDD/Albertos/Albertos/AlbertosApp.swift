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

let menu = [
  MenuItem(category: "starters", name: "Caprese Salad", spicy: false),
  MenuItem(category: "starters", name: "Arancini Balls", spicy: false),
  MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: false),
  MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false),
  MenuItem(category: "drinks", name: "Water", spicy: false),
  MenuItem(category: "drinks", name: "Red Wine", spicy: false),
  MenuItem(category: "desserts", name: "Tiramisù", spicy: false),
  MenuItem(category: "desserts", name: "Crema Catalana", spicy: false),
  MenuItem(category: "pastas", name: "Arrabiata", spicy: true)
]

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            MenuList(viewModel: .init(menuFetching: MenuFetcher()))
              .navigationTitle("Alberto's 🍕")
          }
        }
    }
}
