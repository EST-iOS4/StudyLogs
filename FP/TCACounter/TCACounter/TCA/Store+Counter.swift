//
//  Store+Counter.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

/// 카운터의 상태 전환을 담당하는 Reducer
/// - Parameters:
///   - state: 현재 상태 (inout으로 직접 수정)
///   - action: 발생한 액션
///   - environment: 외부 의존성
/// - Returns: 실행할 Effect (부작용)
func counterReducer(
  state: inout CounterState,
  action: CounterAction,
  environment: CounterEnvironment
) -> Effect<CounterAction> {

  switch action {

    // MARK: - 동기 액션

  case .increment:
    // 카운트 증가
    state.count += 1
    // 에러 초기화
    state.errorMessage = nil
    // 부작용 없음
    return .none

  case .decrement:
    // 카운트 감소
    state.count -= 1
    // 에러 초기화
    state.errorMessage = nil
    // 부작용 없음
    return .none

  case .reset:
    // 모든 상태 초기화
    state.count = 0
    state.isLoading = false
    state.errorMessage = nil
    // 부작용 없음
    return .none

    // MARK: - 비동기 액션

  case .asyncIncrementTapped:
    // 로딩 상태 시작
    state.isLoading = true
    // 이전 에러 초기화
    state.errorMessage = nil

    // 비동기 작업 시작
    return .task { [state] in
      do {
        let result = try await environment.delayedIncrement(2.0, state.count)
        return .asyncIncrementResponse(.success(result))
      } catch let error as AppError {
        return .asyncIncrementResponse(.failure(error))
      } catch {
        return .asyncIncrementResponse(.failure(.unknown))
      }
    }

  case .asyncIncrementResponse(.success(let newCount)):
    // 비동기 작업 성공
    state.count = newCount
    state.isLoading = false
    state.errorMessage = nil
    return .none

  case .asyncIncrementResponse(.failure(let error)):
    // 비동기 작업 실패
    state.isLoading = false
    state.errorMessage = error.message
    return .none

    // MARK: - 에러 관리
  case .clearError:
    // 에러 메시지 제거
    state.errorMessage = nil
    return .none
  }
}

extension Store where State == CounterState, Action == CounterAction, Environment == CounterEnvironment {
  
  static func counter(
    initState: CounterState = CounterState(),
    environment: CounterEnvironment = .live
  ) -> Store<CounterState, CounterAction, CounterEnvironment> {
    Store(
      initialState: initState,
      reducer: counterReducer,
      environment: environment
    )
  }
}
