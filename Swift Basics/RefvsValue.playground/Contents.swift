
struct Point {
  var x: Int
  var y: Int
}

class Person {
  var name: String
  var age: Int

  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

print("=== 값타입 (구조체) 테스트 ===")
var point1 = Point(x: 10, y: 20)
var point2 = point1  // 값이 복사됨

print("변경 전:")
print("point1: (\(point1.x), \(point1.y))")
print("point2: (\(point2.x), \(point2.y))")

point2.x = 100  // point2만 변경

print("\npoint2.x를 100으로 변경 후:")
print("point1: (\(point1.x), \(point1.y))")  // point1은 그대로
print("point2: (\(point2.x), \(point2.y))")  // point2만 변경됨

// MARK: - 참조타입 테스트
print("\n=== 참조타입 (클래스) 테스트 ===")
var person1 = Person(name: "김철수", age: 25)
var person2 = person1  // 참조가 복사됨 (같은 객체를 가리킴)

print("변경 전:")
print("person1: \(person1.name), \(person1.age)세")
print("person2: \(person2.name), \(person2.age)세")

person2.age = 30  // person2를 통해 변경

print("\nperson2.age를 30으로 변경 후:")
print("person1: \(person1.name), \(person1.age)세")  // person1도 함께 변경됨!
print("person2: \(person2.name), \(person2.age)세")  // 같은 객체를 참조

// MARK: - 참조 확인
print("\n=== 참조 동일성 확인 ===")
print("person1과 person2가 같은 객체인가? \(person1 === person2)")

var person3 = Person(name: "이영희", age: 28)
print("person1과 person3이 같은 객체인가? \(person1 === person3)")
