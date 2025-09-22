//
//  UserNaameViewModel.swift
//  UserNameCheck
//
//  Created by Jungman Bae on 9/22/25.
//

import Foundation
import Combine

class UserNameViewModel: ObservableObject {
  @Published var userName = ""
  @Published var availabilityMessage = ""
  @Published var isLoading = false
  @Published var isValid = true

  private let userNameService = UserNameService()
  private var cancellables = Set<AnyCancellable>()

  init() {
    // 실시간 유효성 검사
    $userName
      .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
      .removeDuplicates()
      .sink { [weak self] userName in
        self?.checkUserNameAvailability(userName: userName)
      }
      .store(in: &cancellables)
  }

  private func checkUserNameAvailability(userName: String) {
    guard !userName.isEmpty else {
      availabilityMessage = ""
      isValid = true
      return
    }

    isLoading = true

    userNameService.checkUserNameAvailability(userName: userName)
      .sink(
        receiveCompletion: { [weak self] completion in
          self?.isLoading = false
          if case .failure(let error) = completion {
            self?.availabilityMessage = error.localizedDescription
            self?.isValid = false
          }
        },
        receiveValue: { [weak self] response in
          self?.isLoading = false
          if response.isAvailable {
            self?.availabilityMessage = "✅ 사용 가능한 사용자 이름입니다"
            self?.isValid = true
          } else {
            self?.availabilityMessage = "❌ 이미 사용 중인 사용자 이름입니다"
            self?.isValid = false
          }
        }
      )
      .store(in: &cancellables)
  }
}
