//
//  Article.swift
//  NewsReader
//
//  Created by Jungman Bae on 9/1/25.
//

import Foundation

struct Article: Codable {
  let source: Source
  let author: String?
  let title: String
  let description: String?
  let url: String
  let urlToImage: String?
  let publishedAt: Date
  let content: String?
}
