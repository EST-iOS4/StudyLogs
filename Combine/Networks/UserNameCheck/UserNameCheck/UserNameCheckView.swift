//
//  ContentView.swift
//  UserNameCheck
//
//  Created by Jungman Bae on 9/22/25.
//

import SwiftUI

struct UserNameCheckView: View {
  @StateObject private var viewModel = UserNameViewModel()

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 8) {
          Text("사용자 이름")
            .font(.headline)

          TextField("사용자 이름을 입력하세요", text: $viewModel.userName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)

          HStack {
            if viewModel.isLoading {
              ProgressView()
                .scaleEffect(0.8)
            }

            Text(viewModel.availabilityMessage)
              .font(.caption)
              .foregroundColor(viewModel.isValid ? .green : .red)

            Spacer()
          }
        }

        Spacer()
      }
      .padding()
      .navigationTitle("사용자 이름 확인")
    }
  }
}

#Preview {
  UserNameCheckView()
}
