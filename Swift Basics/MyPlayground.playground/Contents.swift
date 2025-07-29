
// String 타입의 옵셔널 변수 선언
var optionalName: String? = "홍길동"
optionalName = nil // 옵셔널 변수에 nil 할당
print("1. 초기값: \(optionalName ?? "이름없음")") // 출력: "1. 초기값: Optional("홍길동")"

// MARK: - 2. 옵셔널 값 사용하기 (안전한 추출 방법)

var optionalAge: Int? = 25

// --- 2-1. 옵셔널 바인딩 (if let) ---
// 가장 안전하고 권장되는 방법입니다.
// 옵셔널 변수에 값이 있으면, 값을 임시 상수에 담아서 { } 안에서 사용합니다.
print("\n--- 옵셔널 바인딩 (if let) ---")
if let age = optionalAge {
  print("나이는 \(age)살 입니다.") // optionalAge에 값이 있으므로 실행됨
} else {
  print("나이 정보가 없습니다.")
}

// 값이 nil인 경우
var optionalEmail: String? = nil
if let email = optionalEmail {
  print("이메일: \(email)")
} else {
  print("이메일 정보가 없습니다.") // optionalEmail이 nil이므로 실행됨
}


// --- 2-2. 가드 구문 (guard let) ---
// if let과 유사하지만, 함수나 반복문 초반에 사용하여 조건을 만족하지 않으면 빠르게 종료시키는 패턴에 유용합니다.
print("\n--- 가드 구문 (guard let) ---")
func printUserInfo() {
  guard let age = optionalAge else {
    print("나이 정보가 없어 함수를 종료합니다.")
    return
  }

  // guard let으로 추출한 age는 guard 구문 아래에서 계속 사용 가능합니다.
  print("함수 내에서 확인한 나이는 \(age)살 입니다.")
}

printUserInfo()

// MARK: - 4. 옵셔널 체이닝 (Optional Chaining)

// 옵셔널 속성을 연속적으로 안전하게 호출할 때 사용합니다. 중간에 하나라도 nil이면 전체 결과가 nil이 됩니다.
print("\n--- 옵셔널 체이닝 ---")
class Person {
  var address: Address?

  init(address: Address?) {
    self.address = address
  }
}

class Address {
  var street: String = ""
  var city: String?

  init(street: String, city: String?) {
    self.street = street
    self.city = city
  }
}

let personWithAddress = Person(address: Address(street: "강남대로", city: "서울"))
let personWithoutAddress = Person(address: nil)

// 옵셔널 체이닝을 사용하여 안전하게 street 값에 접근
if let street = personWithAddress.address?.street {
  print("주소: \(street)")
} else {
  print("주소 정보 없음")
}

// address가 nil이므로 street에 접근하지 않고 nil을 반환
if let street = personWithoutAddress.address?.street {
  print("주소: \(street)")
} else {
  print("주소 정보 없음")
}

// city는 옵셔널이므로 한번 더 옵셔널 바인딩이 필요할 수 있습니다.
let cityOfPerson: String? = personWithAddress.address?.city // cityOfPerson의 타입은 String?
if let city = cityOfPerson {
  print("도시: \(city)")
}
