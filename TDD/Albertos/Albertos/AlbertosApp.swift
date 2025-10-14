//
//  AlbertosApp.swift
//  Albertos
//
//  Created by Jungman Bae on 10/14/25.
//

import SwiftUI

struct MenuItem {
  let name: String
  let category: String
}

struct MenuSection {
  let category: String
  let items: [MenuItem]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
  return Dictionary(grouping: menu, by: { $0.category })
    .map { key, value in
      MenuSection(category: key, items: value)
    }
    .sorted { $0.category > $1.category }
}


@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
