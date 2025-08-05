//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/4/25.
//

import SwiftUI

struct ContentView: View {
  @State private var username: String = ""
  @State private var password: String = ""

  var body: some View {
    VStack {
      Text("로그인")
        .font(.largeTitle)
        .padding()
      TextField("사용자 이름을 입력하세요", text: $username)
        .padding()
        .border(.black, width: 1)
      SecureField("비밀번호를 입력하세요", text: $password)
        .padding()
        .border(.black, width: 1)
      Button(action: {
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
