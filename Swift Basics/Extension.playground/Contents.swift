import Foundation

extension String {
  func firstWord() -> String {
    let spaceIndex = firstIndex(of: " ") ?? endIndex
    let word = prefix(upTo: spaceIndex)
    return String(word)
  }
}

let sentence = "The quick brown fox jumps over the lazy dog"

let firstWord = sentence.firstWord()
let prefix = sentence.prefix(5)
print("First word: \(firstWord)") // First word: The
print("Prefix: \(prefix)") // Prefix: The

protocol IntRepresentable {
    var intValue: Int { get }
}

extension Int: IntRepresentable {
    var intValue: Int {
        return self
    }
}

extension Double: IntRepresentable {
    var intValue: Int {
        return Int(self)
    }
}

extension String: IntRepresentable {
    var intValue: Int {
        return Int(self) ?? 0
    }
}

let stringValue: String = "42"
print("String value as Int: \(stringValue.intValue)") // String value as Int: 42

enum CrewComplement: Int {
  case enterprise = 1014
  case voyager = 150
  case deepSpaceNine = 2000
}

extension CrewComplement: IntRepresentable {
  var intValue: Int {
    return self.rawValue
  }
}

let voyagerCrew = CrewComplement.voyager
print("Voyager crew complement: \(voyagerCrew.intValue)") // Voyager crew complement: 150
