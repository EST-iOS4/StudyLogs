//
//  AlbertosApp.swift
//  Albertos
//
//  Created by Jungman Bae on 10/14/25.
//

import SwiftUI

struct MenuItem {
  let category: String
  let name: String
}

struct MenuSection {
  let category: String
  let items: [MenuItem]
}

extension MenuItem: Identifiable {
  var id: String { name }
}

extension MenuSection: Identifiable {
  var id: String { category }
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
  return Dictionary(grouping: menu, by: { $0.category })
    .map { key, value in
      MenuSection(category: key, items: value)
    }
    .sorted { $0.category > $1.category }
}

let menu = [
  MenuItem(category: "starters", name: "Caprese Salad"),
  MenuItem(category: "starters", name: "Arancini Balls"),
  MenuItem(category: "pastas", name: "Penne all'Arrabbiata"),
  MenuItem(category: "pastas", name: "Spaghetti Carbonara"),
  MenuItem(category: "drinks", name: "Water"),
  MenuItem(category: "drinks", name: "Red Wine"),
  MenuItem(category: "desserts", name: "Tiramisù"),
  MenuItem(category: "desserts", name: "Crema Catalana"),
]

@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            MenuList(sections: groupMenuByCategory(menu))
              .navigationTitle("Alberto's 🍕")
          }
        }
    }
}
