import Foundation

//var gamesToPlay = Array<String>()
var gamesToPlay = [String]()

gamesToPlay.append("The Secret of Monkey Island")
gamesToPlay.append("Half Life 2")
gamesToPlay.append("Alien Isolation")

print(gamesToPlay.count) // 3

gamesToPlay.insert("Breath of the Wild", at: 2)

print(gamesToPlay.count) // 4
print(gamesToPlay)

let firstGameToPlay = gamesToPlay.first ?? "Unknown"
print(firstGameToPlay) // "The Secret of Monkey Island"
let lastGameToPlay = gamesToPlay.last ?? ""
print(lastGameToPlay) // "Alien Isolation"
