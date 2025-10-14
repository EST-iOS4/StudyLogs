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
  let price: Decimal
}

struct MenuSection {
  let category: String
  let items: [MenuItem]
}

func groupMenuByCategory(_ menu: [MenuItem]) -> [MenuSection] {
  return []
}


@main
struct AlbertosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
