//
//  File.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

/// 비동기 작업의 결과로 발생하는 액션을 나타내는 타입
struct Effect<Action> {
  /// 비동기 작업을 실행하고 액션을 생성하는 클로저
  let run: (@escaping (Action) -> Void) async -> Void

  /// 효과 없음을 나타내는 정적 프로퍼티
  static var none: Effect<Action> {
    Effect { _ in }
  }

  /// 단일 액션을 즉시 반환하는 Effect 생성
  /// - Parameter action: 반환할 액션
  /// - Returns: 해당 액션을 반환하는 Effect
  static func action(_ action: Action) -> Effect<Action> {
    Effect { send in
      send(action)
    }
  }

  /// 비동기 작업을 수행하고 결과를 액션으로 변환
  /// - Parameter work: 비동기 작업
  /// - Returns: 작업 결과를 액션으로 변환하는 Effect
  static func task(_ work: @escaping () async throws -> Action) -> Effect<Action> {
    Effect { send in
      do {
        let action = try await work()
        send(action)
      } catch {
        // 에러 처리는 work 내부에서 수행
      }
    }
  }
}
