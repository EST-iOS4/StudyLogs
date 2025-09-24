//
//  Firestore+getCollection.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/24/25.
//

import Foundation
import Combine
import FirebaseFirestore

extension Firestore {
  func getCollection<T: Codable>(path: String, as _: T.Type) -> AnyPublisher<[T], Error> {
    Future<[T], Error> { promise in
      self.collection(path).getDocuments { snapshot, error in
        if let error {
          promise(.failure(error))
        } else if let documents = snapshot?.documents {
          let items: [T] = documents.compactMap { doc in
            try? doc.data(as: T.self)
          }
          promise(.success(items))
        } else {
          // No error and no snapshot — return an empty array
          promise(.success([]))
        }
      }
    }
    .eraseToAnyPublisher()
  }
}
