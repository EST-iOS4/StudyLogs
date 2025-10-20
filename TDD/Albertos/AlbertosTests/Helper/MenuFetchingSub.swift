//
//  MenuFetchingSub.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/17/25.
//
@testable import Albertos
import Foundation
import Combine

class MenuFetchingSub: MenuFetching {
  let result: Result<[MenuItem], Error>

  init(returning result: Result<[MenuItem],Error>) {
    self.result = result
  }

  func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
    return result.publisher
      .delay(for: 0.1, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
