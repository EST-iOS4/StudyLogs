//
//  ContentView.swift
//  ListNavigation
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct ContentView: View {
  let familyMembers = ["아빠", "엄마", "형", "누나", "동생"]
  let friends = ["친구1", "친구2", "친구3", "친구4"]

  var body: some View {
    List {
      Section("가족") {
        ForEach(familyMembers, id: \.self) { member in
          Text(member)
        }
      }

      Section("친구") {
        ForEach(friends, id: \.self) { friend in
          Text(friend)
        }
      }

    }
    //          .listStyle(.plain)
    //          .listStyle(.inset)
    .listStyle(.grouped)
    //      .listStyle(.insetGrouped)
    //    .listStyle(.sidebar)
  }
}

#Preview {
  ContentView()
}
