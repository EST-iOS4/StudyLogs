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
  var isLoading = false
  var cancellables = Set<AnyCancellable>()
  private var listenerCancellable: AnyCancellable?

  func startListening() {
    isLoading = true

    listenerCancellable = Firestore.firestore()
      .listenToCollection(path: "books", as: Book.self)
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveCancel: { [weak self] in
        self?.isLoading = false
      })
      .sink(receiveCompletion: { [weak self] completion in
        self?.isLoading = false
        if case .failure(let failure) = completion {
          print("Error: \(failure)")
        }
      },
      receiveValue: { [weak self] books in
        print("update!")
        self?.books = books
      })
  }

  func stopListening() {
    listenerCancellable?.cancel()
    listenerCancellable = nil
    isLoading = false
  }

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
