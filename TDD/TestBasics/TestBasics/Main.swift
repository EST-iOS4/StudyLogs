//
//  Main.swift
//  TestBasics
//
//  Created by Jungman Bae on 10/13/25.
//

import Foundation

func isLeap(_ year: Int) -> Bool {
  return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
}

struct Product {
  let category: String
  let price: Double
}

func sumOf(_ products: [Product], withCategory category: String) -> Double {
  return products.reduce(0.0) {
    guard $1.category == category else { return $0 }
    return $0 + $1.price
  }
}

// 사용자 모델
struct User {
  let email: String
  let username: String
  let firstName: String
  let lastName: String
  let password: String
  
  init(email: String, username: String, firstName: String, lastName: String, password: String) throws {
    guard isValidEmail(email) else {
      throw UserError.invalidEmail
    }
    guard username.count <= 10 else {
      throw UserError.usernameTooLong
    }
    guard password.count >= 8 else {
      throw UserError.passwordTooShort
    }
    
    self.email = email
    self.username = username
    self.firstName = firstName
    self.lastName = lastName
    self.password = password
  }
}

enum UserError: Error {
  case invalidEmail
  case usernameTooLong
  case passwordTooShort
}

// 이메일 인증 토큰
struct EmailToken {
  let token: String
  let email: String
  let expiresAt: Date
}

// 이메일 유효성 검사
func isValidEmail(_ email: String) -> Bool {
  let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
  let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
  return emailPredicate.evaluate(with: email)
}

// 회원가입 시 이메일 인증 토큰 발송
func sendEmailVerification(to email: String) -> EmailToken? {
  guard isValidEmail(email) else { return nil }
  
  let token = UUID().uuidString
  let expiresAt = Date().addingTimeInterval(3600) // 1시간 후 만료
  
  return EmailToken(token: token, email: email, expiresAt: expiresAt)
}

// 사용자 이름 유효성 검사
func isValidUsername(_ username: String) -> Bool {
  return username.count <= 10 && !username.isEmpty
}

// 이름 유효성 검사 (First Name, Last Name 구분)
func hasValidNameFormat(firstName: String, lastName: String) -> Bool {
  return !firstName.isEmpty && !lastName.isEmpty
}

// 패스워드 유효성 검사
func isValidPassword(_ password: String) -> Bool {
  return password.count >= 8
}

// 비밀번호 찾기 토큰 발송
func sendPasswordResetToken(to email: String) -> EmailToken? {
  guard isValidEmail(email) else { return nil }
  
  let token = UUID().uuidString
  let expiresAt = Date().addingTimeInterval(1800) // 30분 후 만료
  
  return EmailToken(token: token, email: email, expiresAt: expiresAt)
}
