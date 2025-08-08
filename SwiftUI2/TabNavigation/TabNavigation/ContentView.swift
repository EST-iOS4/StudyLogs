//
//  ContentView.swift
//  TabNavigation
//
//  Created by Jungman Bae on 8/8/25.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedTab = 0
  @State private var previousTab = 0

  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView()
        .tabItem {
          Label("홈", systemImage: "house.fill")
        }
        .tag(0)

      SearchView()
        .tabItem {
          Label("검색", systemImage: "magnifyingglass")
        }
        .tag(1)

      CartView(selectedTab: $selectedTab, previousTab: previousTab)
        .tabItem {
          Label("장바구니", systemImage: "cart.fill")
        }
        .tag(2)
        .badge(1)

      ProfileView()
        .tabItem {
          Label("프로필", systemImage: "person.fill")
        }
        .tag(3)
    }
    .onChange(of: selectedTab) { oldValue, newValue in
      if newValue == 2 && oldValue != 2 {
        // 장바구니 탭으로 이동할 때 이전 탭 저장
        previousTab = oldValue
      } else if newValue == 0 && previousTab == 2 {
        // 홈 탭으로 돌아올 때 장바구니 탭에서 돌아온 경우
        selectedTab = previousTab
      }
      print("탭 변경: \(oldValue) -> \(newValue)")
    }
  }
}

#Preview {
  ContentView()
}
