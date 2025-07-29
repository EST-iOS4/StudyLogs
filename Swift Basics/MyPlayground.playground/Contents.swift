class Person {
  let givenName: String
  let middleName: String
  let familyName: String
  var countryOfResidence: String = "UK"

  init(givenName: String, middleName: String, familyName: String) {
    self.givenName = givenName
    self.middleName = middleName
    self.familyName = familyName
  }

  var displayName: String {
    return "\(fullName()) - Location: \(countryOfResidence)"
  }

  func fullName() -> String {
    return "\(self.givenName) \(self.middleName) \(self.familyName)"
  }
}


let steve = Person(givenName: "Steve", middleName: "Paul", familyName: "Jobs")

print(steve.displayName)
