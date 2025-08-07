//
//  ContentView.swift
//  ListNavigation
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI


struct Person: Identifiable {
  var id = UUID()
  var name: String
}

struct ContentView: View {
  let family = [
    Person(name: "아빠"),
    Person(name: "엄마"),
    Person(name: "형"),
    Person(name: "누나"),
    Person(name: "동생")
  ]

  let friends = [
    Person(name: "친구1"),
    Person(name: "친구2"),
    Person(name: "친구3"),
    Person(name: "친구4"),
    Person(name: "친구5")
  ]

  var body: some View {
    List {
      Section("가족") {
        ForEach(family) { member in
          Text(member.name)
        }
      }

      Section("친구") {
        ForEach(friends) { friend in
          Text(friend.name)
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
