import Foundation

func makeSandwichSync(bread: String, ingredients: [String]) async -> String {
  print("샌드위치 준비 중...")

  async let toastedBread = toastBread(bread)
  async let slicedIngredients = slice(ingredients)

  return assemble(await toastedBread, await slicedIngredients)
}

func toastBread(_ bread: String) async -> String {
  print("빵 토스트 중...")
  try? await Task.sleep(nanoseconds: 5_000_000_000) // 메인 스레드 차단
  return "바삭한 \(bread)"
}

func slice(_ ingredients: [String]) async -> [String] {
  var result = [String]()
  for ingredient in ingredients {
    print("\(ingredient) 자르는 중...")
    try? await Task.sleep(nanoseconds: 1_000_000_000)
    result.append("자른 \(ingredient)")
  }
  return result
}

func assemble(_ toastedBread: String, _ slicedIngredients: [String]) -> String {
  print(toastedBread)
  print(slicedIngredients)
  return "토스트"
}

Task {
  let sandwich = await makeSandwichSync(bread: "빵", ingredients: ["햄", "오이", "달걀"])
  print("완성: \(sandwich)")
}
