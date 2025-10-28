
protocol Semigroup {
  func operation(_ element: Self) -> Self
}

extension Int: Semigroup {
  func operation(_ element: Int) -> Int {
    return self + element
  }
}

extension String: Semigroup {
  func operation(_ element: String) -> String {
    return self + element
  }
}


extension Array: Semigroup {
  func operation(_ element: Array<Element>) -> Array<Element> {
    self + element
  }
}


precedencegroup AssociativityLeft {
  associativity: left
}

infix operator <> : AssociativityLeft

func <> <S: Semigroup>(lhs: S, rhs: S) -> S {
  return lhs.operation(rhs)
}

print(3 <> 5 <> 7)

// 결합 법칙 테스트
let x = 3
let y = 5
let z = 7

let result1 = x.operation(y.operation(z))
let result2 = (x.operation(y)).operation(z)
print(result1 == result2)  // 출력: true (결합 법칙 만족)

protocol Monoid: Semigroup {
  static func identity() -> Self
}

extension Int: Monoid {
  static func identity() -> Int {
    return 0
  }
}

extension String: Monoid {
  static func identity() -> String {
    return ""
  }
}

extension Array: Monoid {
  static func identity() -> Array<Element> {
    return []
  }
}


print((5 <> Int.identity()) == 5)

func mconcat<M: Monoid>(_ elements: [M]) -> M {
  return elements.reduce(M.identity(), <>)
}

print(mconcat([1,2,3,4,5]))
print(mconcat(["Hello", " ", "Functional", " ", "Swift"]))


