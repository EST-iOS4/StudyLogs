//
//  NetworkError.swift
//  NewsReader
//
//  Created by Jungman Bae on 9/1/25.
//

import Foundation

enum NetworkError: LocalizedError {
  case invalidURL
  case invalidResponse
  case noData
  case decodingError
  case serverError(statusCode: Int)
  case unknown

  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "잘못된 URL입니다."
    case .invalidResponse:
      return "서버 응답이 올바르지 않습니다."
    case .noData:
      return "데이터가 없습니다."
    case .decodingError:
      return "데이터 파싱에 실패했습니다."
    case .serverError(let statusCode):
      return "서버 에러: \(statusCode)"
    case .unknown:
      return "알 수 없는 에러가 발생했습니다."
    }
  }
}
