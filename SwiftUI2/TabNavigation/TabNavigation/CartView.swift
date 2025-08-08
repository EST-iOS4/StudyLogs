//
//  CartView.swift
//  TabNavigation
//
//  Created by Jungman Bae on 8/8/25.
//
import SwiftUI

struct CartView: View {
  @Binding var selectedTab: Int
  var previousTab: Int = 0

  var body: some View {
    NavigationStack {
      VStack {
        Text("장바구니 화면")
          .font(.largeTitle)
          .padding()

        Button("홈으로 이동") {
          selectedTab = 0
        }
        .padding()

        Button("이전 탭으로 돌아가기") {
          selectedTab = previousTab
        }
      }
    }
  }
}
