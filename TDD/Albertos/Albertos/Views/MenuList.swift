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
  @EnvironmentObject var orderController: OrderController

  @State private var items: [MenuItem] = []
  @State private var showSpicy = false

  @ObservedObject var viewModel: ViewModel

  var presentation: MenuPresentation {
    let allItems: [MenuItem]

    switch viewModel.sections {
    case .success(let sections):
      allItems = sections.flatMap { $0.items }
    case .failure:
      allItems = []
    }
    
    return MenuPresentation(
      allItems: allItems,
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
              NavigationLink(destination: destination(for: item)) {
                MenuRow(viewModel: .init(item: item))
              }
            }
          }
        }
      } else {
        switch viewModel.sections {
        case .success(let sections):
          ForEach(sections) { section in
            Section(header: Text(section.category)) {
              ForEach(section.items) { item in
                NavigationLink(destination: destination(for: item)) {
                  MenuRow(viewModel: .init(item: item))
                }
              }
            }
          }
        case .failure(let error):
          Text("Error loading menu: \(error.localizedDescription)")
            .foregroundColor(.red)
        }
      }
    }
  }

  private func destination(for item: MenuItem) -> some View {
    MenuItemDetail(
      viewModel: .init(item: item, orderController: orderController)
    )
  }
}
