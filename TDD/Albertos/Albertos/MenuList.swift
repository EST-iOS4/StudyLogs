//
//  MenuList.swift
//  Albertos
//
//  Created by Jungman Bae on 10/14/25.
//

import SwiftUI


struct MenuPresentation {
  let allItems: [MenuItem]
  let showOnlySpicy: Bool

  var displayedItems: [MenuItem] {
    if showOnlySpicy {
      return allItems.filter { $0.spicy }
    } else {
      return allItems
    }
  }

  var emptyStateMessage: String? {
    if showOnlySpicy && displayedItems.isEmpty {
      return "매운 메뉴가 없습니다."
    }
    return nil
  }
}

struct MenuList: View {
  let sections: [MenuSection]
  @State private var items: [MenuItem] = []
  @State private var showSpicy = false

  var presentation: MenuPresentation {
    MenuPresentation(
      allItems: sections.flatMap { $0.items },
      showOnlySpicy: showSpicy
    )
  }

  var body: some View {
    List {
      Toggle("Spicy Only", isOn: $showSpicy)

      if showSpicy {
        Section(header: Text("Spicy 🌶️")) {
          if let emptyStateMessage = presentation.emptyStateMessage {
            Text(emptyStateMessage)
          } else {
            ForEach(presentation.displayedItems, id: \.name) { item in
              Text(item.name)
            }
          }
        }
      } else {
        ForEach(sections) { section in
          Section(header: Text(section.category)) {
            ForEach(section.items) { item in
              Text(item.name)
            }
          }
        }
      }
    }
  }
}

#Preview {
  MenuList(sections: [])
}
