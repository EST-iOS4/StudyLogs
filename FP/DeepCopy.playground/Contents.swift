import Foundation

protocol DeepCopyable {
  func deepCopy() -> Self
}

final class Address: Equatable, DeepCopyable {

  static func == (lhs: Address, rhs: Address) -> Bool {
    return lhs.street == rhs.street && lhs.city == rhs.city
  }

  var street: String
  var city: String

  required init(street: String, city: String) {
    self.street = street
    self.city = city
  }

  func deepCopy() -> Address {
    return Address(street: street, city: city)
  }
}

let address1 = Address(street: "street1", city: "city1")

let address2 = address1.deepCopy()

let address3 = address1

print(address1 == address2)
print(address1 === address2)
print(address1 == address3)
print(address1 === address3)
