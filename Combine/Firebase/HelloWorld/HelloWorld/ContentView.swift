//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/24/25.
//

import SwiftUI
import Combine

struct ContentView: View {
  @State var bookViewModel = BookViewModel()

  var body: some View {
    VStack {
      List(bookViewModel.books) { book in
        Text(book.title)
      }
      if bookViewModel.isLoading {
        ProgressView()
        Button("종료") {
          bookViewModel.stopListening()
        }

      } else {
        Button("새로고침") {
          bookViewModel.fetchData()
        }
      }
    }
    .padding()
    .onAppear {
      bookViewModel.startListening()
    }
  }
}

#Preview {
  ContentView()
}
