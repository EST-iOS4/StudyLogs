
struct Queue<Element> {
  private var front: [Element]
  private var back: [Element]

  init() {
    self.front = []
    self.back = []
  }

  private init(front: [Element], back: [Element]) {
    self.front = front
    self.back = back
  }

  var isEmpty: Bool {
    front.isEmpty && back.isEmpty
  }

  // enqueue: O(1)
  func enqueue(_ element: Element) -> Queue {
    return Queue(front: front, back: [element] + back)
  }

  // dequeue: 분할 상환 O(1)
  func dequeue() -> (Element, Queue)? {
    if front.isEmpty && back.isEmpty {
      return nil
    }

    let newFront = front.isEmpty ? back.reversed() : front
    let newBack = front.isEmpty ? [] : back

    guard let head = newFront.first else { return nil }
    let tail = Array(newFront.dropFirst())

    return (head, Queue(front: tail, back: newBack))
  }

  // peek
  func peek() -> Element? {
    return front.first ?? back.last
  }
}

var queue = Queue<Int>()
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)
  .enqueue(1)


while let (element, newQueue) = queue.dequeue() {
  print("element: \(element)")
  queue = newQueue
}
