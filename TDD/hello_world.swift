#!/usr/bin/env swift
import Foundation

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

func main() {
  guard CommandLine.argc > 1 else {
    print("Hello, world!")
    return
  }

  if let number = Int(CommandLine.arguments[1]) {
    print(fizzBuzz(number))
  } else {
    print("Hello, world!")
  }
}

main()
