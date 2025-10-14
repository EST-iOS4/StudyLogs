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
  guard menu.isEmpty == false else { return [] }
  return [MenuSection(category: "category", items: menu)]
}


@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
