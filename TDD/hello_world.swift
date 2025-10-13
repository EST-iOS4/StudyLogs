#!/usr/bin/env swift
import Foundation

func main() {
  guard CommandLine.argc > 1 else {
    print("Hello, world!")
    return
  }

  let name = CommandLine.arguments[1]
  print("Hello, \(name)!")
}

main()
