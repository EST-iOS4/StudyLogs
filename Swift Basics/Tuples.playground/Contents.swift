import Foundation

func normalizedStarRating(forRating rating: Float, ofPossibleTotal total: Float) -> (Int, String) {
  let fraction = rating / total
  let ratingOutOf5 = fraction * 5
  let roundedRating = round(ratingOutOf5) // 가장 가까운 정수로 반올림
  let numberOfStars = Int(roundedRating) // Float를 Int로 변환
  let ratingString = "\(numberOfStars) Star Movie"
  return (numberOfStars, ratingString)
}

let ratingAndDisplayString = normalizedStarRating(forRating: 5, ofPossibleTotal: 10)

print("Rating: \(ratingAndDisplayString.0) stars")
print("Display String: \(ratingAndDisplayString.1)")
