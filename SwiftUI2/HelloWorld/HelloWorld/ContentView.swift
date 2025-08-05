//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  @State private var email: String = ""
  @State private var username: String = ""
  @State private var password: String = ""
  @State private var confirmPassword: String = ""

  var body: some View {
    VStack {
      Label("회원가입", systemImage: "person.crop.circle.fill.badge.plus")
        .font(.largeTitle)
        .padding()

      HStack {
        Image("flag")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 50, height: 50)
          .clipShape(Circle())
        Text("회원가입")
          .font(.largeTitle)
      }
      .font(.largeTitle)



      TextField("이메일", text: $email)
        .keyboardType(.emailAddress) // 이메일 입력을 위한 키보드 타입
        .submitLabel(.next) // 다음 버튼을 표시
        .autocapitalization(.none) // 텍스트 필드 자동 대문자 변환을 방지
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))

      TextField("사용자 이름을 입력하세요", text: $username)
        .padding()
        .autocapitalization(.none) // 텍스트 필드 자동 대문자 변환을 방지
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      SecureField("비밀번호를 입력하세요", text: $password)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      SecureField("비밀번호 확인 ", text: $confirmPassword)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
      Button(action: {
        if password != confirmPassword {
          print("비밀번호가 일치하지 않습니다.")
          return
        }
        print("사용자 이름: \(username), 비밀번호: \(password)")
        // API 호출
      }) {
        Text("로그인")
          .frame(minWidth: 0, maxWidth: .infinity)
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
