//
//  TodoReducer.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

typealias TodoStore = Store<TodoState, TodoAction, TodoEnvironment>

//let todoReducer = { (
//  state:inout ,
//  environment: TodoEnvironment
//) -> Effect<TodoAction> in
//  return
//}
//
//extension Store where State == TodoState, Action == TodoAction, Environment == TodoEnvironment {
//  static let todoStore: TodoStore = {
//    Store(initialState: , reducer: , environment: )
//  }
//}
