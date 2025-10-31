//
//  CounterAction.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

/// 카운터에서 발생할 수 있는 모든 액션
enum CounterAction: Equatable {
  /// 카운트 즉시 증가
  case increment

  /// 카운트 즉시 감소
  case decrement

  /// 카운트 0으로 리셋
  case reset

  /// 비동기 증가 시작
  case asyncIncrementTapped

  /// 비동기 증가 완료 (성공)
  case asyncIncrementResponse(Result<Int, AppError>)

  /// 에러 메시지 제거
  case clearError
}

