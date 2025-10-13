//
//  TestBasicsSwiftTestings.swift
//  TestBasicsSwiftTestings
//
//  Created by Jungman Bae on 10/13/25.
//

import Testing

struct TestBasicsSwiftTestings {

  @Test("4로 나누어 떨어지면 윤년")
  func evenlyDivisibleBy4IsLeap() {
    #expect(isLeap(2020))
  }

}
