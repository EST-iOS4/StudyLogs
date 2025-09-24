//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/24/25.
//

import SwiftUI

struct ContentView: View {
  @State var bookViewModel = BookViewModel()

  var body: some View {
    VStack {
      List(bookViewModel.books) { book in
        Text(book.title)
      }
      Button("새로고침") {
        bookViewModel.fetchData()
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
