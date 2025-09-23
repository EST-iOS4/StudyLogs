//
//  DataViewModel.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation
import Combine

final class DataViewModel: ObservableObject {
  @Published var isLoading = false
  @Published var errorMessage = ""
  @Published var data: [String] = []

  private let client = NetworkClient()
  private var cancellables = Set<AnyCancellable>()
  private let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!

  func fetchData() {
    isLoading = true
    errorMessage = ""
    client.request(url)
      .decode(type: [Todo].self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self else { return }
          self.isLoading = false
          if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] values in
          self?.data = values.map(\.title)
        }
      )
      .store(in: &cancellables)
  }
}
