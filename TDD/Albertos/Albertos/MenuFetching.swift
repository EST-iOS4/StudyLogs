//
//  MenuFetching.swift
//  Albertos
//
//  Created by Jungman Bae on 10/15/25.
//

import Combine

protocol MenuFetching {
  nonisolated func fetchMenu() -> AnyPublisher<[MenuItem], any Error>
}
