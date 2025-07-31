
protocol Container {
  associatedtype Item
  mutating func add(_ item: Item)
  var count: Int { get }
}

struct IntStack: Container {
  typealias Item = Int
  private var items: [Int] = []

  mutating func add(_ item: Int) {
    items.append(item)
  }

  var count: Int {
    return items.count
  }

  public func getItems() -> [Int] {
    // validation
    return items
  }
}

var intStack = IntStack()

intStack.add(1)
intStack.add(2)

print("IntStack count: \(intStack.count)") // IntStack count: 2
print("IntStack items: \(intStack.getItems())") // IntStack items: [1, 2]


struct StringStack: Container {
  typealias Item = String
  private var items: [String] = []

  mutating func add(_ item: String) {
    items.append(item)
  }

  var count: Int {
    return items.count
  }

  public func getItems() -> [String] {
    // validation
    return items
  }
}

var stringStack = StringStack()

stringStack.add("Hello")
stringStack.add("World")

print("StringStack count: \(stringStack.count)") // StringStack count: 2
print("StringStack items: \(stringStack.getItems())") // StringStack items: ["Hello", "World"]
