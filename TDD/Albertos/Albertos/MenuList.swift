//
//  MenuList.swift
//  Albertos
//
//  Created by Jungman Bae on 10/14/25.
//

import SwiftUI

struct MenuList: View {
  let sections: [MenuSection]
  var body: some View {
    List {
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

#Preview {
  MenuList(sections: [])
}
