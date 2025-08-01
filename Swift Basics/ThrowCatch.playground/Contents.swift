
enum MealState {
  case initial // 요리 시작
  case buyIngredients // 재료 구매
  case prepareIngredients // 재료 준비
  case cook // 요리
  case plateUp // 플레이팅
  case serve // 서빙
}

enum MealError: Error {
  case canOnlyMoveToAppropriateState // 적절한 상태로만 이동 가능
}

class Meal {
  private(set) var state: MealState = .initial // 읽기 전용 속성 private(set)

  // 단계별로 상태를 변경하는 메서드
  func change(to newState: MealState) throws {
    switch (state, newState) {
    case (.initial, .buyIngredients),
      (.buyIngredients, .prepareIngredients),
      (.prepareIngredients, .cook),
      (.cook, .plateUp),
      (.plateUp, .serve):
      state = newState
    default:
      throw MealError.canOnlyMoveToAppropriateState // 순서가 잘못되었다는 오류
    }
  }
}

let dinner = Meal()
print("Current dinner state #1: \(dinner.state)") // Current dinner state: initial
//dinner.state = .buyIngredients 직접 접근은 오류
do {
  try dinner.change(to: .buyIngredients) // 재료 구매 단계로 변경
  print("Current dinner state #2: \(dinner.state)") // Current dinner state: initial
  try dinner.change(to: .serve)
} catch let error {
  print("Error changing state: \(error)")
}

