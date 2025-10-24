
func makeIncrementer(increment: Int) -> () -> Int {
  var total = 0

  let incrementer = {
    total += increment
    return total
  }

  return incrementer
}

let incrementByFive = makeIncrementer(increment: 5)

print(incrementByFive())
print(incrementByFive())
print(incrementByFive())

let incrementByTen = makeIncrementer(increment: 10)

print(incrementByTen())
print(incrementByTen())
print(incrementByTen())

func applyOperation(_ numbers: [Int], operation: (Int) -> Int) -> [Int] {
  return numbers.map(operation)
}

let values = [1,2,3,4,5]

let doubled = applyOperation(values) { $0 * 2 }
print("2배: \(doubled)")

let squared = applyOperation(values) { $0 * $0 }
print("제곱: \(squared)")

let incremented = applyOperation(values) { $0 + 10 }
print("10 증가: \(incremented)")

// 명령형에서 선언형으로 변환

let numbers = [1,2,3,4,5,6,7,8,9,10]

// 명령형 방식
var evenSquaredSum1 = 0
for number in numbers {
  if number % 2 == 0 {
    evenSquaredSum1 += number * number
  }
}
print("명령형 결과: \(evenSquaredSum1)")


// 선언형 방식
let evenSquaredSum2 = numbers.filter { $0 % 2 == 0 }.map { $0 * $0 }.reduce(0, +)
print("선언형 결과: \(evenSquaredSum2)")
