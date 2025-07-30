
enum CompassDirection {
  case north
  case south
  case east
  case west
}

let direction: CompassDirection = CompassDirection.south

print("The direction is \(direction)")

if direction == .south {
  print("We are heading south!")
} else if direction == .north {
  print("We are heading north!")
} else if direction == .east {
  print("We are heading east!")
} else if direction == .west {
  print("We are heading west!")
} else {
  print("Unknown direction")
}

switch direction {
case .north:
  print("We are heading north!")
case .south:
  print("We are heading south!")
case .east:
  print("We are heading east!")
case .west:
  print("We are heading west!")
}

