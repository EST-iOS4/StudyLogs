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
  @State private var items: [MenuItem] = []
  @State private var showSpicy = false

  let viewModel: ViewModel

  var presentation: MenuPresentation {
    MenuPresentation(
      allItems: viewModel.sections.flatMap { $0.items },
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
              MenuRow(viewModel: .init(item: item))
            }
          }
        }
      } else {
        ForEach(viewModel.sections) { section in
          Section(header: Text(section.category)) {
            ForEach(section.items) { item in
              MenuRow(viewModel: .init(item: item))
            }
          }
        }
      }
    }
  }
}

extension MenuList {
  struct ViewModel {
    let sections: [MenuSection]

    init(
      menu: [MenuItem],
      menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        self.sections = menuGrouping(menu)
      }
  }
}
