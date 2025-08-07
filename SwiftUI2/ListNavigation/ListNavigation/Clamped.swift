//
//  Clamped.swift
//  ListNavigation
//
//  Created by Jungman Bae on 8/7/25.
//

import Foundation

@propertyWrapper // 1. 이 타입이 프로퍼티 래퍼임을 선언합니다.
struct Clamped {
  private var value: Int
  let min: Int
  let max: Int

  // 2. 'wrappedValue'는 필수 구현 프로퍼티입니다.
  //    실제 값이 저장되고 반환되는 통로 역할을 합니다.
  var wrappedValue: Int {
    get { return value }
    set {
      // 3. set 로직에 값을 제한하는 핵심 로직을 넣습니다.
      if newValue < min {
        value = min
      } else if newValue > max {
        value = max
      } else {
        value = newValue
      }
    }
  }

  // 4. 래퍼를 초기화하는 init을 만듭니다.
  //    wrappedValue는 초기값을, min/max는 제한 범위를 받습니다.
  init(wrappedValue: Int, min: Int, max: Int) {
    self.min = min
    self.max = max
    // 초기값도 범위 제한을 받도록 value를 직접 설정하지 않고,
    // wrappedValue의 set 로직을 타도록 합니다.
    self.value = 0 // 임시 초기화
    self.wrappedValue = wrappedValue
  }
}
