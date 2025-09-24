//
//  BookViewModel.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/24/25.
//

import Foundation
import FirebaseFirestore
import Combine
import SwiftUI

@Observable
final class BookViewModel {
  var books: [Book] = []
  var cancellables = Set<AnyCancellable>()

  func fetchData() {
    Firestore.firestore()
      .getCollection(path: "books", as: Book.self)
      .sink(receiveCompletion: {_ in },
            receiveValue: { books in
        self.books = books
            })
      .store(in: &cancellables)
  }
}
