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
  @State var family = [
    Person(name: "아빠"),
    Person(name: "엄마"),
    Person(name: "형"),
    Person(name: "누나"),
    Person(name: "동생")
  ]

  @State var friends = [
    Person(name: "친구1"),
    Person(name: "친구2"),
    Person(name: "친구3"),
    Person(name: "친구4"),
    Person(name: "친구5")
  ]

  var body: some View {
    NavigationStack {
      List {
        Section("가족") {
          ForEach(family) { member in
            Text(member.name)
              .swipeActions(edge: .leading) {
                Button {
                } label: {
                  Label("즐겨찾기", systemImage: "star")
                }
                .tint(.yellow)
              }
          }
          .onMove(perform: { indices, newOffset in
            family.move(fromOffsets: indices, toOffset: newOffset)
          })
        }
        
        Section("친구") {
          ForEach(friends) { friend in
            Text(friend.name)
              .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                  // 친구 삭제 처리
                } label: {
                  Label("삭제", systemImage: "trash")
                }
              }
          }
          .onDelete(perform: { indexSet in
            friends.remove(atOffsets: indexSet)
          })
        }
      }
      .toolbar {
        EditButton()
      }
    }
  }
}

#Preview {
  ContentView()
}
