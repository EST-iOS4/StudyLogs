//
//  CounterViewModel.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/30/25.
//

import SwiftUI

typealias CounterStore = Store<CounterState, CounterAction, CounterEnvironment>

@MainActor
@Observable
class CounterViewModel {

  private var store: CounterStore

  init(store: CounterStore) {
    self.store = store
  }

  var count: Int = 0
  var isLoading = false
  var errorMessage: String?

  func clearError() {
//    store.send(.clearError)
  }

  func decrement() {
//    store.send(.decrement)
  }

  func increment() {
//    store.send(.increment)
  }

  func asyncIncrementTapped() {
//    store.send(.asyncIncrementTapped)
  }

  func reset() {
//    store.send(.reset)
  }
}
