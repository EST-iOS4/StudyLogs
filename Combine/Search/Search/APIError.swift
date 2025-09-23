//
//  APIError.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation

enum APIError: Error, LocalizedError {
  case invalidURL
  case noData
  case decodingError
  case serverError(Int)
  case networkError(URLError)

  var errorDescription: String? {
    switch self {
    case .invalidURL: return "잘못된 URL입니다"
    case .noData: return "데이터가 없습니다"
    case .decodingError: return "데이터 형식이 올바르지 않습니다"
    case .serverError(let code): return "서버 오류 (\(code))"
    case .networkError(let error): return "네트워크 오류: \(error.localizedDescription)"
    }
  }
}
