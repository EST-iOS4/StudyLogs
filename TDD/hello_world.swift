#!/usr/bin/env swift
import Foundation
import XCTest

class FizzBuzzTests: XCTestCase {
  func testFizzBuzzWithThree() {
    XCAssertEqual(fizzBuzz(3), "fizz")
  }
  func testFizzBuzzWithFive() {
    XCAssertEqual(fizzBuzz(5), "buzz")
  }
  func testFizzBuzzWithFifteen() {
    XCAssertEqual(fizzBuzz(15), "fizz-buzz")
  }
  func testFizzBuzzWithOne() {
    XCAssertEqual(fizzBuzz(1), "1")
  }
}

func fizzBuzz(_ number: Int) -> String {
  let divisibleBy3 = number % 3 == 0
  let divisibleBy5 = number % 5 == 0

  switch (divisibleBy3, divisibleBy5) {
  case (false,false): return "\(number)"
  case (true, false): return "fizz"
  case (false, true): return "buzz"
  case (true, true): return "fizz-buzz"
  }
}

func testFizzBuzzOld() {
  if fizzBuzz(3) == "fizz" {
    print("PASSED")
  } else {
    print("FAILED")
  }
  if fizzBuzz(5) == "buzz" {
    print("PASSED")
  } else {
    print("FAILED")
  }
  // ... 모든 케이스를 넣어줄 수 없다.
}

// 개선된 버전
func test(value: String, matches expected: String) {
  if value == expected {
    print("PASSED")
  } else {
    print("FAILED")
  }
}

func testFizzBuzz() {
  test(value: fizzBuzz(1), matches: "1")
  test(value: fizzBuzz(3), matches: "fizz")
  test(value: fizzBuzz(5), matches: "buzz")
  test(value: fizzBuzz(15), matches: "fizz-buzz")
}

func main() {
  guard CommandLine.argc > 1 else {
    print("Hello, world!")
    testFizzBuzz()
    return
  }

  if let number = Int(CommandLine.arguments[1]) {
    print(fizzBuzz(number))
  } else {
    print("Hello, world!")
  }
}

main()
