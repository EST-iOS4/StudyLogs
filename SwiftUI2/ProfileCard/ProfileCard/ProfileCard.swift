//
//  ContentView.swift
//  ProfileCard
//
//  Created by Jungman Bae on 8/6/25.
//

import SwiftUI

struct ProfileCard: View {
  var body: some View {
    VStack(spacing: 20) {
      // 프로필 이미지
      Image(systemName: "person.circle.fill")
        .font(.system(size: 100))
        .foregroundStyle(.blue)

      VStack(spacing: 5) {
        Text("김스위프트")
          .font(.title)
          .fontWeight(.bold)

        Text("iOS 개발자")
          .font(.subheadline)
          .foregroundStyle(.secondary)
      }

      HStack(spacing: 30) {
        VStack {
          Text("42")
            .font(.title2)
            .fontWeight(.semibold)

          Text("프로젝트")
            .font(.caption)
            .foregroundStyle(.secondary)
        }

        VStack {
          Text("128")
            .font(.title2)
            .fontWeight(.semibold)

          Text("팔로워")
            .font(.caption)
            .foregroundStyle(.secondary)
        }

        VStack {
          Text("75")
            .font(.title2)
            .fontWeight(.semibold)

          Text("팔로잉")
            .font(.caption)
            .foregroundStyle(.secondary)
        }
      }

      Button(action: {
        // 버튼 클릭 시 동작
      }) {
        Text("팔로우")
          .font(.headline)
          .frame(width: 200, height: 50)
          .foregroundStyle(.white)
          .background(Color.blue)
          .cornerRadius(25)
      }
    }
    .padding()
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .shadow(radius: 10)
  }
}

#Preview {
  ProfileCard()
}
