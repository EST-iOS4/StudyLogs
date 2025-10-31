//
//  CounterEnvironment.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

/// 카운터가 필요로 하는 외부 의존성을 캡슐화
struct CounterEnvironment {
  /// 지연 시간을 가진 비동기 작업을 수행하는 함수
  /// - Parameters:
  ///   - delay: 지연 시간(초)
  ///   - value: 반환할 값
  /// - Returns: 지연 후 반환되는 값
  var delayedIncrement: (TimeInterval, Int) async throws -> Int

  /// 메인 큐 (UI 업데이트용)
  var mainQueue: DispatchQueue
}

// MARK: - Live Environment (실제 운영 환경)
extension CounterEnvironment {
  /// 실제 운영 환경에서 사용할 Environment
  static let live = CounterEnvironment(
    delayedIncrement: { delay, value in
      // Task.sleep을 사용한 실제 지연
      try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))

      // 10% 확률로 에러 발생 (시뮬레이션)
      if Int.random(in: 0...9) == 0 {
        throw AppError.networkFailure
      }

      return value + 1
    },
    mainQueue: .main
  )
}
