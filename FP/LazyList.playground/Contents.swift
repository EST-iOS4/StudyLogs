precedencegroup AssociativityRight {
  associativity: right
}

enum LazyList<Element: Equatable> {
  case end
  case node(data: Element, next: () -> LazyList<Element>)

  // 지연 cons 연산자
  static func cons(_ element: Element, next: @escaping @autoclosure () -> LazyList) -> LazyList {
    return .node(data: element, next: next)
  }
}

// 지연 cons 연산자
infix operator <|| : AssociativityRight

func <||<T>(lhs: T, rhs: @escaping @autoclosure () -> LazyList<T>) -> LazyList<T> {
  return .node(data: lhs, next: rhs)
}

extension LazyList {
  var size: Int {
    switch self {
    case .node(_, let next):
      return 1 + next().size
    case .end:
      return 0
    }
  }

  var elements: [Element] {
    switch self {
    case .node(let data, let next):
      return [data] + next().elements
    case .end:
      return []
    }
  }

  // map (지연 평가)
  func map<T>(_ transform: @escaping (Element) -> T) -> LazyList<T> {
    switch self {
    case .end:
      return .end
    case .node(let data, let next):
      return transform(data) <|| next().map(transform)
    }
  }

  // filter (지연 평가)
  func filter(_ predicate: @escaping (Element) -> Bool) -> LazyList<Element> {
    switch self {
    case .end:
      return .end
    case .node(let data, let next):
      return predicate(data) ? data <|| next().filter(predicate) : next().filter(predicate)
    }
  }

  // take: 처음 n개만 가져오기
  func take(_ n: Int) -> LazyList {
    guard n > 0 else { return .end }

    switch self {
    case .end:
      return .end
    case .node(let data, let next):
      return data <|| next().take(n - 1)
    }
  }
}

func infiniteNumbers(from: Int = 0) -> LazyList<Int> {
  return from <|| infiniteNumbers(from: from + 1)
}
let infinite = infiniteNumbers()
let first5 = infinite.take(5)
print("처음 5개: \(first5.elements)")  // 출력: 처음 5개: [0, 1, 2, 3, 4]

let evenSquares = infinite
  .filter { $0 % 2 == 0 }
  .map { $0 * $0 }
  .take(3)

print("짝수의 제곱 3개: \(evenSquares.elements)")  // 출력: 짝수의 제곱 3개: [0, 4, 16]
