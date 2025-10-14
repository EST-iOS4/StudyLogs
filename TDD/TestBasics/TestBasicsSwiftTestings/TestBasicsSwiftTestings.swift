//
//  TestBasicsSwiftTestings.swift
//  TestBasicsSwiftTestings
//
//  Created by Jungman Bae on 10/13/25.
//

import Testing
import Foundation

struct TestBasicsSwiftTestings {

  @Test("빈 제품 배열의 합은 0을 반환")
  func sumOfEmptyArrayIsZero() {
    // Arrange
    let category = "books"
    let products = [Product]()

    // Act
    let sum = sumOf(products, withCategory: category)

    // Assert
    #expect(sum == 0)
  }

  @Test("하나의 아이템의 합은 아이템의 가격을 반환")
  func sumOfOneItemIsItemPrice() {
    // Arrange
    let category = "books"
    let product = Product(category: category, price: 3)
    let products = [product]

    // Act
    let sum = sumOf(products, withCategory: category)

    // Assert
    #expect(sum == product.price)
  }

  @Test("필터링된 카테고리의 합을 반환")
  func sumIsSumOfItemsPricesForGivenCategory() {
    // Arrange
    let category = "books"
    let products = [
      Product(category: category, price: 3),
      Product(category: "movies", price: 2),
      Product(category: category, price: 1),
    ]
    let expectValue = products
      .filter{ $0.category == category }
      .reduce(0.0) { $0 + $1.price }

    // Act
    let sum = sumOf(products, withCategory: category)

    // Assert
    #expect(sum == expectValue)
  }

  @Test("4로 나누어 떨어지면 윤년")
  func evenlyDivisibleBy4IsLeap() {
    #expect(isLeap(2020))
  }

  @Test("4로 나누어 떨어지지 않으면 평년")
  func notEvenlyDivisibleBy4IsNotLeap() {
    #expect(!isLeap(2021))
  }

  @Test("100으로 나누어 떨어지는 경우 평년")
  func evenlyDivisibaleBy100IsNotLeap() {
    #expect(!isLeap(2100))
  }

  @Test("400으로 나누어 떨어지는 경우 윤년")
  func evenlyDivisibaleBy400IsLeap() {
    #expect(isLeap(2000))
  }

  @Test("회원 가입시 이메일로 인증")
  func emailVerificationOnSignUp() {
    // Arrange
    let email = "test@example.com"
    
    // Act
    let token = sendEmailVerification(to: email)
    
    // Assert
    #expect(token != nil, "유효한 이메일로 인증 토큰이 생성되어야 함")
    #expect(token?.email == email, "토큰의 이메일이 요청한 이메일과 일치해야 함")
    #expect(token?.expiresAt.timeIntervalSinceNow ?? 0 > 0, "토큰이 미래 시간에 만료되어야 함")
  }
  
  @Test("사용자 이름은 10자 이내")
  func usernameWithin10Characters() {
    // Arrange & Act & Assert
    // 10자 이내의 사용자명은 유효해야 함
    #expect(isValidUsername("user123"), "10자 이내의 사용자명은 유효해야 함")
    #expect(isValidUsername("a"), "1자 사용자명도 유효해야 함")
    #expect(isValidUsername("1234567890"), "정확히 10자 사용자명도 유효해야 함")
    
    // 10자를 초과하는 사용자명은 유효하지 않아야 함
    #expect(!isValidUsername("12345678901"), "10자를 초과하는 사용자명은 유효하지 않아야 함")
    #expect(!isValidUsername(""), "빈 문자열은 유효하지 않아야 함")
  }
  
  @Test("글로벌 서비스를 위해 First Name Last Name으로 구분해야 함")
  func firstNameLastNameSeparation() {
    // Arrange & Act & Assert
    // 올바른 First Name, Last Name 형식
    #expect(hasValidNameFormat(firstName: "John", lastName: "Doe"), "First Name과 Last Name이 모두 있어야 유효함")
    #expect(hasValidNameFormat(firstName: "김", lastName: "철수"), "한글 이름도 유효해야 함")
    
    // 잘못된 형식
    #expect(!hasValidNameFormat(firstName: "", lastName: "Doe"), "First Name이 비어있으면 유효하지 않음")
    #expect(!hasValidNameFormat(firstName: "John", lastName: ""), "Last Name이 비어있으면 유효하지 않음")
    #expect(!hasValidNameFormat(firstName: "", lastName: ""), "둘 다 비어있으면 유효하지 않음")
  }
  
  @Test("패스워드는 8자 이상 입력해야함")
  func passwordMinimum8Characters() throws {
    // Arrange & Act & Assert
    // 8자 이상의 패스워드는 유효해야 함
    #expect(isValidPassword("12345678"), "정확히 8자 패스워드는 유효해야 함")
    #expect(isValidPassword("password123!@#"), "8자 이상의 패스워드는 유효해야 함")
    
    // 8자 미만의 패스워드는 유효하지 않아야 함
    #expect(!isValidPassword("1234567"), "7자 패스워드는 유효하지 않아야 함")
    #expect(!isValidPassword(""), "빈 패스워드는 유효하지 않아야 함")
    
    // User 생성 시 패스워드 검증 테스트
    #expect(throws: UserError.passwordTooShort) {
      _ = try User(email: "test@example.com", username: "user", firstName: "John", lastName: "Doe", password: "1234567")
    }
    
    // 유효한 패스워드로 User 생성 성공
    let user = try User(email: "test@example.com", username: "user", firstName: "John", lastName: "Doe", password: "12345678")
    #expect(user.password == "12345678", "유효한 패스워드로 사용자 생성이 성공해야 함")
  }
  
  @Test("비밀번호 찾기 기능은 토큰을 이메일로 발송함")
  func passwordResetTokenSentByEmail() {
    // Arrange
    let validEmail = "user@example.com"
    let invalidEmail = "invalid-email"
    
    // Act & Assert
    // 유효한 이메일로 패스워드 리셋 토큰 발송
    let token = sendPasswordResetToken(to: validEmail)
    #expect(token != nil, "유효한 이메일로 패스워드 리셋 토큰이 생성되어야 함")
    #expect(token?.email == validEmail, "토큰의 이메일이 요청한 이메일과 일치해야 함")
    #expect(token?.expiresAt.timeIntervalSinceNow ?? 0 > 0, "토큰이 미래 시간에 만료되어야 함")
    
    // 유효하지 않은 이메일로 패스워드 리셋 토큰 발송 실패
    let invalidToken = sendPasswordResetToken(to: invalidEmail)
    #expect(invalidToken == nil, "유효하지 않은 이메일로는 토큰이 생성되지 않아야 함")
  }


}
