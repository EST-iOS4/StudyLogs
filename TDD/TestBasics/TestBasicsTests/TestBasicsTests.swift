//
//  TestBasicsTests.swift
//  TestBasicsTests
//
//  Created by Jungman Bae on 10/13/25.
//

import XCTest

final class TestBasicsTests: XCTestCase {

  func testEvenlyDivisibleBy4IsLeap() {
    XCTAssertTrue(isLeap(2020))
  }

  func testNotEvenlyDivisibleBy4IsNotLeap() {
    XCTAssertFalse(isLeap(2021))
  }

  func testEvenlyDivisibleBy100IsNotLeap() {
    XCTAssertFalse(isLeap(2100))
  }

  func testEvenlyDivisibleBy400IsLeap() {
    XCTAssertTrue(isLeap(2000))
  }
}
