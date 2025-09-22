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

  init() {
    setupValidation()
  }

  private func setupValidation() {
    $email
      .map { email in
        email.contains("@") && email.contains(".")
      }
      .assign(to: &$isEmailValid)

    $password
      .map { password in
        password.count >= 8
      }
      .assign(to: &$isPasswordValid)

    $password
      .combineLatest($confirmPassword)
      .map { password, confirmPassword in
        password == confirmPassword && !password.isEmpty
      }
      .assign(to: &$passwordMatch)

    $isEmailValid
      .combineLatest($isPasswordValid, $passwordMatch)
      .map { $0 && $1 && $2 }
      .assign(to: &$isFormValid)
  }
}

struct SignUpForm: View {
  @StateObject var viewModel = SignUpFormViewModel()

  private var emailMessage: String {
    viewModel.email.isEmpty || viewModel.isEmailValid ? "" : "Enter a valid email address."
  }

  private var passwordMessage: String {
    if viewModel.password.isEmpty && viewModel.confirmPassword.isEmpty { return "" }
    var parts: [String] = []
    if !viewModel.isPasswordValid { parts.append("Password must be at least 8 characters.") }
    if !viewModel.passwordMatch { parts.append("Passwords must match.") }
    return parts.joined(separator: " ")
  }

  var body: some View {
    Form {
      // Email
      Section {
        TextField("Email", text: $viewModel.email)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .keyboardType(.emailAddress)
      } footer: {
        Text(emailMessage)
          .foregroundColor(.red)
      }

      // Password
      Section {
        SecureField("Password", text: $viewModel.password)
        SecureField("Repeat password", text: $viewModel.confirmPassword)
      } footer: {
        Text(passwordMessage)
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
