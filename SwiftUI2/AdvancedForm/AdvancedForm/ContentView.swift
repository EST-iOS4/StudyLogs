//
//  ContentView.swift
//  AdvancedForm
//
//  Created by Jungman Bae on 8/8/25.
//

import SwiftUI

struct ContentView: View {
  @State private var name = ""
  @State private var birthDate = Date()
  @State private var gender = "선택안함"
  @State private var receiveNotifications = true
  @State private var notificationTime = Date()
  @State private var selectedInterests = Set<String>()
  @State private var bio = ""

  let genders = ["남성", "여성", "기타", "선택안함"]

  let interests = [
    "스포츠",
    "음악",
    "여행",
    "독서",
    "영화",
    "요리",
    "기타"
  ]

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("개인 정보")) {
          TextField("이름", text: $name)
            .textContentType(.name)

          DatePicker("생년월일", selection: $birthDate, displayedComponents: .date)

          Picker("성별", selection: $gender) {
            ForEach(genders, id: \.self) { genderElement in
              Text(genderElement)
            }
          }
        }
        Section(header: Text("알림 설정")) {
          Toggle("알림 받기", isOn: $receiveNotifications)

          if receiveNotifications {
            DatePicker("알림 시간", selection: $notificationTime, displayedComponents: .hourAndMinute)
          }
        }
        Section(header: Text("관심사 (최대 3개)")) {
          ForEach(interests, id: \.self) { interest in
            HStack {
              Text(interest)
              Spacer()
              if selectedInterests.contains(interest) {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundStyle(.blue)
              }
            }
            .contentShape(Rectangle())
            .onTapGesture {
              toggleInterest(interest)
            }
          }
        }
        Section(header: Text("자기소개")) {
          TextEditor(text: $bio)
            .frame(minHeight: 100)
            .autocorrectionDisabled()
        }
        Section {
          Button("프로필 저장") {
            // 저장 로직 구현
            print("이름: \(name)")
            print("생년월일: \(birthDate)")
          }
          .disabled(name.isEmpty)
        }
      }
      .navigationTitle("프로필 설정")
    }
  }

  func toggleInterest(_ interest: String) {
    if selectedInterests.contains(interest) {
      selectedInterests.remove(interest)
    } else if selectedInterests.count < 3 {
      selectedInterests.insert(interest)
    }
  }
}

#Preview {
  ContentView()
}
