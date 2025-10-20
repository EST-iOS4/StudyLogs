//
//  NetworkFetcing.swift
//  Albertos
//
//  Created by Jungman Bae on 10/20/25.
//

import Foundation
import Combine

protocol NetworkFetching {
  func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}
