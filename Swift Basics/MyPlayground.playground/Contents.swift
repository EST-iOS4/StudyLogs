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

final class Family: Person {
  let relationship: String

  init(givenName: String, middleName: String, familyName: String = "Barker", relationship: String) {
    self.relationship = relationship
    super.init(givenName: givenName, middleName: middleName, familyName: familyName)
  }

  override var displayName: String {
    return "\(super.displayName) - \(relationship)"
  }
}

let steve = Person(givenName: "Steve", middleName: "Paul", familyName: "Jobs")
let sam = Friend(givenName: "Sam", middleName: "John", familyName: "Smith")
sam.whereWeMet = "Tech Conference"
let sarah = Family(givenName: "Sarah", middleName: "Jane", familyName: "Doe", relationship: "Sister")
let john = Family(givenName: "John", middleName: "Michael", familyName: "Doe", relationship: "Brother")


print(steve.displayName)
print(sam.displayName)

print(sarah.displayName)
print(john.displayName)
