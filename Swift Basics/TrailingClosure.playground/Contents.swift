

let numbers = [1, 2, 3, 4, 5]

// 일반 클로저
let doubled = numbers.map({ $0 * 2 })
// 후행 클로저
let doubled2 = numbers.map() { $0 * 2 }
// 후행 클로저 + 함수 괄호 생략
let doubled3 = numbers.map { $0 * 2 }
