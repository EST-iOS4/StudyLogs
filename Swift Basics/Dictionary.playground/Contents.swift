
struct PersonName {
  let givenName: String
  let familyName: String
}

enum CommunicationMethod {
  case phone
  case email
  case textMessage
  case fax
  case telepathy
  case subSpaceRelay
  case tachyons
}

class Person {
  let name: PersonName
  let preferredCommunicationMethod: CommunicationMethod

  init(name: PersonName, commsMethod: CommunicationMethod) {
    self.name = name
    preferredCommunicationMethod = commsMethod
  }

  convenience init(givenName: String, familyName: String, commsMethod: CommunicationMethod) {
    let name = PersonName(givenName: givenName, familyName: familyName)
    self.init(name: name, commsMethod: commsMethod)
  }

  var displayName: String {
    return "\(name.givenName) \(name.familyName)"
  }
}

var crew = Dictionary<String, Person>()

crew["Captain"] = Person(givenName: "Jean-Luc", familyName: "Picard", commsMethod: .phone)
crew["First Officer"] = Person(givenName: "William", familyName: "Riker", commsMethod: .email)
crew["Chief Engineer"] = Person(givenName: "Geordi", familyName: "LaForge", commsMethod: .textMessage)
crew["Second Officer"] = Person(givenName: "Data", familyName: "Soong", commsMethod: .fax)
crew["Councillor"] = Person(givenName: "Deanna", familyName: "Troi", commsMethod: .telepathy)
crew["Security Officer"] = Person(givenName: "Tasha", familyName: "Yar", commsMethod: .subSpaceRelay)
crew["Chief Medical Officer"] = Person(givenName: "Beverly", familyName: "Crusher", commsMethod: .tachyons)

let roles = Array(crew.keys)
print(roles)

let firstRole = roles.first! // Chief Medical Officer
let cmo: Person = crew[firstRole]!
print("\(firstRole): \(cmo.displayName)") // Chief Medical Officer: Beverly Crusher
