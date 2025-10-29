final class Storage<T> {
  var value: T

  init(_ value: T) {
    self.value = value
  }
}

struct COWArray<Element> {
  private var storage: Storage<[Element]>

  init(_ elements: [Element] = []) {
    self.storage = Storage(elements)
  }

  private var array: [Element] {
    get { storage.value }
    set {
      if !isKnownUniquelyReferenced(&storage) {
        storage = Storage(newValue)
      } else {
        storage.value = newValue
      }
    }
  }

  var count: Int {
    return array.count
  }

  subscript(index: Int) -> Element {
    get { array[index] }
    set {
      var newArray = array
      newArray[index] = newValue
      array = newArray
    }
  }

  mutating func append(_ element: Element) {
    var newArray = array
    newArray.append(element)
    array = newArray
  }
}

var cow1 = COWArray([1,2,3])
var cow2 = cow1

cow2.append(4)

print(cow1.count)
print(cow2.count)
