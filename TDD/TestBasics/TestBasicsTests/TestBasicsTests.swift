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

}
