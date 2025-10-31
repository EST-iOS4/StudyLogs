//
//  Store.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation
import Combine

class Store<State, Action, Environment>: ObservableObject {

  // MARK: - Properties

  /// 현재 상태 (Published로 자동 업데이트)
  @Published private(set) var state: State

  /// Reducer 함수
  private let reducer: (inout State, Action, Environment) -> Effect<Action>

  /// Environment (의존성)
  private let environment: Environment

  /// 실행 중인 Effect를 저장하는 Set
  private var effectCancellables: Set<AnyCancellable> = []

  // MARK: - Initialization

  /// Store 초기화
  /// - Parameters:
  ///   - initialState: 초기 상태
  ///   - reducer: Reducer 함수
  ///   - environment: Environment
  init(
    initialState: State,
    reducer: @escaping (inout State, Action, Environment) -> Effect<Action>,
    environment: Environment
  ) {
    self.state = initialState
    self.reducer = reducer
    self.environment = environment
  }

  // MARK: - Public Methods

  /// 액션을 디스패치하여 상태를 업데이트
  /// - Parameter action: 디스패치할 액션
  func send(_ action: Action) {
    let effect = reducer(&state, action, environment)

    // Effect 실행
    Task { @MainActor [weak self] in
      guard let self = self else { return }

      await effect.run { [weak self] action in
        self?.send(action)
      }
    }
  }
}
