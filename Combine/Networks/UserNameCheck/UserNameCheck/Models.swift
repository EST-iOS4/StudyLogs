//
//  Models.swift
//  UserNameCheck
//
//  Created by Jungman Bae on 9/22/25.
//

import Foundation

struct UserNameResponse: Codable {
  let isAvailable: Bool
  let userName: String
}

enum APIError: Error, LocalizedError {
  case invalidURL
  case noData
  case decodingError
  case networkError(Error)

  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "잘못된 URL입니다."
    case .noData:
      return "데이터를 받을 수 없습니다."
    case .decodingError:
      return "데이터 파싱에 실패했습니다."
    case .networkError(let error):
      return "네트워크 오류: \(error.localizedDescription)"
    }
  }
}
