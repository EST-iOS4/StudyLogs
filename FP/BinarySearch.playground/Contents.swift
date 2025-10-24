
func binarySearch<T: Comparable>(_ array: [T], target: T, range: Range<Int>? = nil) -> Int? {

  let range = range ?? 0..<array.count

  guard range.lowerBound < range.upperBound else { return nil }

  let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
  let midValue = array[midIndex]

  if midValue == target {
    return midIndex
  } else if midValue > target {
    return binarySearch(
      array,
      target: target,
      range: range.lowerBound..<midIndex
    )
  } else {
    return binarySearch(
      array,
      target: target,
      range: midIndex..<range.upperBound
    )
  }
}

let sortedNumbers = [1,3,5,7,9,11,13,15,17,19]

print(binarySearch(sortedNumbers, target: 7)!)
print(binarySearch(sortedNumbers, target: 13)!)
print(binarySearch(sortedNumbers, target: 20) ?? "nil")

