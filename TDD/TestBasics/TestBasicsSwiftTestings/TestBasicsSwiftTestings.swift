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

  @Test("4로 나누어 떨어지지 않으면 평년")
  func notEvenlyDivisibleBy4IsNotLeap() {
    #expect(!isLeap(2021))
  }

  @Test("100으로 나누어 떨어지는 경우 평년")
  func evenlyDivisibaleBy100IsNotLeap() {
    #expect(!isLeap(2100))
  }

  @Test("400으로 나누어 떨어지는 경우 윤년")
  func evenlyDivisibaleBy400IsLeap() {
    #expect(isLeap(2000))
  }

}
