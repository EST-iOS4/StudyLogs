//
//  MenuRow.swift
//  Albertos
//
//  Created by Jungman Bae on 10/14/25.
//

import SwiftUI

struct MenuRow: View {
  let viewModel: ViewModel

  var body: some View {
    Text(viewModel.text)
  }
}

extension MenuRow {
  struct ViewModel {
    let text: String
    init(item: MenuItem) {
      text = item.spicy ? "\(item.name) 🔥" : item.name
    }
  }
}
