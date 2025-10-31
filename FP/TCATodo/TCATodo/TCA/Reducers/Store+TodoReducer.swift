//
//  Store+TodoReducer.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

extension Store where State == TodoState, Action == TodoAction, Environment == TodoEnvironment {
  static func todoStore(
    initState: TodoState = TodoState(),
    environment: TodoEnvironment = .live) -> TodoStore {
      return Store(initialState: initState, reducer: todoReducer, environment: environment)
    }
}
