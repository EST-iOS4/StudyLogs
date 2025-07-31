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

//numbers.map { numberElement in
//  return numberElement * 2
//}
let doubledNumbers = numbers.map { $0 * 2 }

print(doubledNumbers) // [2, 4, 6, 8, 10]

// 짝수만 필터링
let evenNumbers = numbers.filter { $0 % 2 == 0 }

// 5보다 작은 수만 필터링
let smallNumbers = numbers.filter { number in
  return number < 5
}

print(evenNumbers) // [2, 4]
print(smallNumbers) // [1, 2, 3, 4]

// 모든 수의 합
let sum = numbers.reduce(0) { result, number in
  return result + number
}

// 더 간단하게
let sum2 = numbers.reduce(0) { $0 + $1 }
let sum3 = numbers.reduce(0, +)  // 가장 간단


print(sum)   // 15
print(sum2)  // 15
print(sum3)  // 15

let twoDemensionalArray = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

let sum2DArray = twoDemensionalArray.map { row in
  return row.reduce(0) { $0 + $1 }
}

let totalSum2DArray = sum2DArray.reduce(0) { $0 + $1 }

print(sum2DArray)
print(totalSum2DArray) // 45


print("\n=== 클로저의 캡처 ===")

func makeCounter() -> () -> Int {
  var count = 0
  return {
    count += 1
    return count
  }
}

let counter = makeCounter()
print("첫 번째 호출: \(counter())")  // 1
print("두 번째 호출: \(counter())")  // 2
print("세 번째 호출: \(counter())")  // 3
