//
//  SignUpForm.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/22/25.
//

import SwiftUI
import Combine

class SignUpFormViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""

  @Published var isEmailValid = false
  @Published var isPasswordValid = false
  @Published var passwordMatch = false
  @Published var isFormValid = false

  @Published var emailMessage = ""
  @Published var passwordMessage = ""


  private lazy var isEmailValidPublisher: AnyPublisher<Bool, Never> = {
    $email
      .map { email in
        email.contains("@") && email.contains(".")
      }
      .eraseToAnyPublisher()
  }()

  private lazy var isPasswordLengthValidPublisher: AnyPublisher<Bool, Never> = {
    $password
      .map { password in
        password.count >= 8
      }
      .eraseToAnyPublisher()
  }()

  private lazy var isPasswordValidPublisher: AnyPublisher<Bool, Never> = {
    $password
      .combineLatest($confirmPassword)
      .map { password, confirmPassword in
        password == confirmPassword && !password.isEmpty
      }
      .eraseToAnyPublisher()
  }()

  init() {
    setupValidation()
  }

  private func setupValidation() {
    isEmailValidPublisher
      .assign(to: &$isEmailValid)

    isEmailValidPublisher
      .map { $0 ? "" : "Enter a valid email address." }
      .assign(to: &$emailMessage)

    isPasswordLengthValidPublisher
      .assign(to: &$isPasswordValid)

    isPasswordValidPublisher
      .assign(to: &$passwordMatch)

    isPasswordLengthValidPublisher
      .combineLatest(isPasswordValidPublisher)
      .map { lengthValid, matchValid in
        if !lengthValid {
          return "비밀번호는 8자 이상 입력하세요."
        } else if !matchValid {
          return "비밀번호가 일치하지 않습니다."
        }
        return ""
      }
      .assign(to: &$passwordMessage)

    $isEmailValid
      .combineLatest($isPasswordValid, $passwordMatch)
      .map { $0 && $1 && $2 }
      .assign(to: &$isFormValid)
  }
}

struct SignUpForm: View {
  @StateObject var viewModel = SignUpFormViewModel()

  var body: some View {
    Form {
      // Email
      Section {
        TextField("Email", text: $viewModel.email)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .keyboardType(.emailAddress)
      } footer: {
        Text(viewModel.emailMessage)
          .foregroundColor(.red)
      }

      // Password
      Section {
        SecureField("Password", text: $viewModel.password)
        SecureField("Repeat password", text: $viewModel.confirmPassword)
      } footer: {
        Text(viewModel.passwordMessage)
          .foregroundColor(.red)
      }

      // Submit button
      Section {
        Button("Sign up") {
          print("Signing up as \(viewModel.email)")
        }
        .disabled(!viewModel.isFormValid)
      }
    }
  }
}

#Preview {
  SignUpForm()
}
