//
//  MenuFetching.swift
//  Albertos
//
//  Created by Jungman Bae on 10/15/25.
//

import Combine

protocol MenuFetching {
  func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
