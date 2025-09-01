//
//  NewsAPIService.swift
//  NewsReader
//
//  Created by Jungman Bae on 9/1/25.
//

import Foundation

class NewsAPIService {
  private let apiKey = "b026d8374164440488a002a3173e8016" // 2025년 9월 2일 만료
  private let baseURL = "https://newsapi.org/v2"
  private let session = URLSession.shared

  func fetchTopHeadlines(
    country: String = "us",
    category: String? = nil,
    completion: @escaping (Result<[Article], Error>) -> Void
  ) {
    var components = URLComponents(string: "\(baseURL)/top-headlines")!
    var queryItems = [
      URLQueryItem(name: "country", value: country),
      URLQueryItem(name: "apiKey", value: apiKey)
    ]

    if let category = category {
      queryItems.append(URLQueryItem(name: "category", value: category))
    }

    components.queryItems = queryItems

    guard let url = components.url else {
      completion(.failure(NetworkError.invalidURL))
      return
    }

    let task = session.dataTask(with: url) { data, response, error in
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
        return
      }

      guard let data = data else {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.noData))
        }
        return
      }

      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // yyyy-mm-DD HH:MM:ss
        let response = try decoder.decode(NewsResponse.self, from: data)

        DispatchQueue.main.async {
          completion(.success(response.articles))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }

    task.resume()
  }

}
