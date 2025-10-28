
enum BST<Element: Comparable> {
  case leaf
  indirect case node(lhs: BST, element: Element, rhs: BST)

  init() {
    self = .leaf
  }

  init(element: Element) {
    self = .node(lhs: .leaf, element: element, rhs: .leaf)
  }

  static func contains(_ item: Element, tree: BST<Element>) -> Bool {
    switch tree {
    case .leaf:
      return false
    case .node(let lhs, let element, let rhs):
      if item < element {
        return contains(item, tree: lhs)
      } else if item > element {
        return contains(item, tree: rhs)
      }
      return true
    }
  }

  var size: Int {
    switch self {
    case .leaf: return 0
    case .node(let lhs, _, let rhs):
      return  1 + lhs.size + rhs.size
    }
  }

  var elements: [Element] {
    switch self {
    case .leaf: return []
    case .node(let lhs, let element, let rhs):
      return lhs.elements + [element] + rhs.elements
    }
  }

  func insert(_ value: Element) -> BST {
    switch self {
    case .leaf: return .node(lhs: .leaf, element: value, rhs: .leaf)
    case .node(let lhs, let element, let rhs):
      if value < element {
        return .node(lhs: lhs.insert(value), element: element, rhs: rhs)
      } else if value > element {
        return .node(lhs: lhs, element: element, rhs: rhs.insert(value))
      } else {
        return self
      }
    }
  }
}

extension BST {
  static func example() -> BST<Int> {
    return .node(
      lhs: .node(lhs: .leaf, element: 1, rhs: .leaf),
      element: 5,
      rhs: .node(lhs: .leaf, element: 9, rhs: .leaf)
    )
  }
}

// 테스트
let bst = BST<Int>.example()
print("크기: \(bst.size)")  // 출력: 크기: 3
print("요소들: \(bst.elements)")  // 출력: 요소들: [1, 5, 9]
print("5 포함? \(BST.contains(5, tree: bst))")  // 출력: 5 포함? true
print("7 포함? \(BST.contains(7, tree: bst))")  // 출력: 7 포함? false

// 새 값 삽입 (불변)
let newBST = bst.insert(3)
print("새 BST 요소들: \(newBST.elements)")  // 출력: 새 BST 요소들: [1, 3, 5, 9]
print("원본 BST 요소들: \(bst.elements)")  // 출력: 원본 BST 요소들: [1, 5, 9]


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


