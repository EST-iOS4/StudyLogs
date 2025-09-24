//
//  Book.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/24/25.
//

import Foundation
import FirebaseFirestore

struct Book: Identifiable, Codable {
  @DocumentID var id: String?
  let title: String
  let author: String
  let publishedDate: Date

  var dictionary: [String: Any] {
    return [
      "title": title,
      "author": author,
      "publishedDate": Timestamp(date: publishedDate)
    ]
  }
}
