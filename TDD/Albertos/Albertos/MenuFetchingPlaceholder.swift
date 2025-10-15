//
//  MenuFetchingPlaceholder.swift
//  Albertos
//
//  Created by Jungman Bae on 10/15/25.
//

import Combine
import Foundation

class MenuFetchingPlaceholder: MenuFetching {
  func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
    return Future { $0(.success(menu))}
      .delay(for: 0.5, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
