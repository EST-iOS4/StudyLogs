//
//  Todo.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation

struct Todo: Codable {
  let userId: Int
  let id: Int
  let title: String
  let completed: Bool
}
