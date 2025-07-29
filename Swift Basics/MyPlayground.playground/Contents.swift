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

final class Friend: Person {
  var whereWeMet: String?

  override var displayName: String {
    var baseDisplayName = super.displayName
    if let meetingPlace = whereWeMet {
      baseDisplayName += " - Met at: \(meetingPlace)"
    }
    return baseDisplayName
  }
}

let steve = Person(givenName: "Steve", middleName: "Paul", familyName: "Jobs")
let sam = Friend(givenName: "Sam", middleName: "John", familyName: "Smith")
sam.whereWeMet = "Tech Conference"

print(steve.displayName)
print(sam.displayName)
