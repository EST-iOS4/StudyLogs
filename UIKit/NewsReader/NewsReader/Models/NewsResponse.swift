//
//  NewsResponse.swift
//  NewsReader
//
//  Created by Jungman Bae on 9/1/25.
//

import Foundation

struct NewsResponse: Codable {
  let status: String
  let totalResults: Int
  let articles: [Article]
}
