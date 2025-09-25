//
//  Firestore+listenToCollection.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/25/25.
//

import FirebaseFirestore
import Combine

extension Firestore {
  func listenToCollection<T: Codable>(path: String, as _: T.Type) -> AnyPublisher<[T], Error> {
    let subject = PassthroughSubject<[T], Error>()

    let listener = self.collection(path)
      .addSnapshotListener { snapshot, error in
        if let error {
          subject.send(completion: .failure(error))
        } else if let documents = snapshot?.documents {
          let items = documents.compactMap { doc in
            try? doc.data(as: T.self)
          }
          subject.send(items)
        }
      }

    return subject.handleEvents(receiveCancel: {
      listener.remove()
    })
    .eraseToAnyPublisher()
  }
}
