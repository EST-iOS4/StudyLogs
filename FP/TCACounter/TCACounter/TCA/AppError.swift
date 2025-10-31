//
//  AppError.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

/// 앱에서 발생할 수 있는 에러 타입
enum AppError: Error, Equatable {
  case networkFailure
  case timeout
  case unknown

  var message: String {
    switch self {
    case .networkFailure:
      return "네트워크 연결에 실패했습니다."
    case .timeout:
      return "요청 시간이 초과되었습니다."
    case .unknown:
      return "알 수 없는 오류가 발생했습니다."
    }
  }
}
