//
//  LoginView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/25/25.
//

import SwiftUI

struct LoginView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var isLoading = false
  @State private var errorMessage = ""

  @EnvironmentObject var auth: AuthenticationService

  var body: some View {
    VStack(spacing: 20) {
      Text("도서 관리 앱")
        .font(.largeTitle)
        .fontWeight(.bold)

      VStack(spacing: 15) {
        TextField("이메일", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .autocapitalization(.none)

        SecureField("비밀번호", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())

        if !errorMessage.isEmpty {
          Text(errorMessage)
            .foregroundColor(.red)
            .font(.caption)
        }

        Button(action: signIn) {
          if isLoading {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle())
          } else {
            Text("로그인")
          }
        }
        .disabled(isLoading)
        .buttonStyle(.borderedProminent)
      }
      .padding()
    }
    .padding()
  }

  private func signIn() {
    isLoading = true
    errorMessage = ""

    auth.signIn(email: email, password: password) { result in
      DispatchQueue.main.async {
        isLoading = false

        switch result {
        case .success:
          break // 자동으로 인증 상태 변경됨
        case .failure(let error):
          errorMessage = error.localizedDescription
        }
      }
    }
  }
}

#Preview {
  LoginView()
}
