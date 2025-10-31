//
//  CounterViewModel.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/30/25.
//

import SwiftUI
import Combine

typealias CounterStore = Store<CounterState, CounterAction, CounterEnvironment>

@MainActor
@Observable
class CounterViewModel {

  private var store: CounterStore

  private var cancellables = Set<AnyCancellable>();

  init(store: CounterStore) {
    self.store = store

    store.$state
      .map(\.count)
      .assign(to: \.count, on: self)
      .store(in: &cancellables)

    store.$state
      .map(\.isLoading)
      .assign(to: \.isLoading, on: self)
      .store(in: &cancellables)

    store.$state
      .map(\.errorMessage)
      .assign(to: \.errorMessage, on: self)
      .store(in: &cancellables)
  }

  var count: Int = 0
  var isLoading = false
  var errorMessage: String?

  func clearError() {
    store.send(.clearError)
  }

  func decrement() {
    store.send(.decrement)
  }

  func increment() {
    store.send(.increment)
  }

  func asyncIncrementTapped() {
    store.send(.asyncIncrementTapped)
  }

  func reset() {
    store.send(.reset)
  }
}
