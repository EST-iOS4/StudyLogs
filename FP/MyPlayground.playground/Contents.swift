
func sumOf(numbers: Int..., b: Int) -> (sum: Int, count: Int) {
  var sum = 0
  var count = 0
  for number in numbers {
    sum += number
    count += 1
  }
  return (sum, count)
}

let result = sumOf(numbers: 7,8,9,10,20, b: 10)
print("합계: \(result.sum), 개수: \(result.count)")
