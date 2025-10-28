import Foundation

struct WeaklyImmutable {
  let id: Int
  var name: String
}

let example = WeaklyImmutable(id: 1, name: "Intial")

example.name = "Changed"
