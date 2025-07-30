
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

// 각 케이스가 고유한 연관 값을 가질 수 있습니다.
enum Media {
  case book(title: String, author: String, year: Int)
  case movie(title: String, director: String, runningTime: Int)
  case music(title: String, artist: String, album: String)
}

let myBook: Media = .book(title: "스위프트 프로그래밍", author: "야곰", year: 2022)
let myMovie = Media.movie(title: "올드보이", director: "박찬욱", runningTime: 120)
let myMusic = Media.music(title: "Hype Boy", artist: "NewJeans", album: "New Jeans")

func printMediaInfo(for media: Media) {
  switch media {
  case .book(let title, let author, let year):
    print("📚 책 정보")
    print("   - 제목: \(title)")
    print("   - 저자: \(author)")
    print("   - 출판년도: \(year)년")

  case .movie(let title, let director, let time):
    print("🎬 영화 정보")
    print("   - 제목: \(title)")
    print("   - 감독: \(director)")
    print("   - 상영시간: \(time)분")

    // 'let'을 괄호 밖으로 빼서 한번에 바인딩할 수도 있습니다.
  case let .music(title, artist, album):
    print("🎵 음악 정보")
    print("   - 제목: \(title)")
    print("   - 아티스트: \(artist)")
    print("   - 앨범: \(album)")
  }
}

printMediaInfo(for: myBook)
printMediaInfo(for: myMovie)
printMediaInfo(for: myMusic)
