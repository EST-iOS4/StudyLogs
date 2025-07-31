import Foundation

func add(a: Int, b: Int) -> Int {
  return a + b
}

let addClosure: (Int, Int) -> Int = { a, b in
  return a + b
}

print(add(a: 3, b: 5)) // 8
print(addClosure(3, 5)) // 8

let numbers = [1, 2, 3, 4, 5]

// numbers.map({ numberElement in numberElement * 2 })
let doubledNumbers = numbers.map { $0 * 2 }

print(doubledNumbers) // [2, 4, 6, 8, 10]
