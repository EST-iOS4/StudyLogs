//
//  MenuFetcher.swift
//  Albertos
//
//  Created by Jungman Bae on 10/17/25.
//
import Combine
import Foundation

class MenuFetcher: MenuFetching {
  func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
    let url = URL(string: "https://raw.githubusercontent.com/mokagio/tddinswift_fake_api/trunk/menu_response.json")!
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: [MenuItem].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
