import Foundation

func makeSandwichSync(bread: String, ingredients: [String]) -> String {
  print("샌드위치 준비 중...")

  let toastedBread = toastBread(bread)

  let slicedIngredients = slice(ingredients)

  return assemble(toastedBread, slicedIngredients)
}

func toastBread(_ bread: String) -> String {
  print("빵 토스트 중...")
  Thread.sleep(forTimeInterval: 5.0) // 메인 스레드 차단
  return "바삭한 \(bread)"
}

func slice(_ ingredients: [String]) -> [String] {
  return ingredients.map { ingredient in
    print("\(ingredient) 자르는 중...")
    Thread.sleep(forTimeInterval: 1.0)
    return "자른 \(ingredient)"
  }
}

func assemble(_ toastedBread: String, _ slicedIngredients: [String]) -> String {
  return "토스트 완성"
}

makeSandwichSync(bread: "빵", ingredients: ["햄", "오이", "달걀"])
