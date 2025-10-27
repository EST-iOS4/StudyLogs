protocol Container {
  associatedtype Item
  mutating func append(_ item: Item)
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
  typealias Item = Int
  private var items: [Int] = []

  mutating func append(_ item: Int) {
    items.append(item)
  }

  var count: Int { items.count }

  subscript(i: Int) -> Int { items[i] }
}

var stack = IntStack()
stack.append(1)
stack.append(2)
stack.append(3)
print(stack[0])
print(stack.count)

struct GenericStack<Element>: Container {
  private var items: [Element] = []

  mutating func append(_ item: Element) {
    items.append(item)
  }

  var count: Int { items.count }

  subscript(i: Int) -> Element { items[i] }
}

var stack2 = GenericStack<Int>()
stack2.append(1)
stack2.append(2)
stack2.append(3)
print(stack2[0])
print(stack2.count)

