//
//  CounterState.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/31/25.
//

import Foundation

struct CounterState: Equatable {
  /// 현재 카운트 값
  var count: Int = 0

  /// 비동기 작업 진행 중 여부
  var isLoading: Bool = false

  /// 발생한 에러 메시지 (옵셔널)
  var errorMessage: String? = nil

  /// 에러 발생 여부를 계산하는 편의 프로퍼티
  var hasError: Bool {
    errorMessage != nil
  }
}
