//
//  DataViewModel.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import Foundation
import Combine

enum SearchPhase {
  case idle
  case loading
  case results([String])
  case empty
  case failed(String)
}

final class DataViewModel: ObservableObject {
  @Published var isLoading = false
  @Published var errorMessage = ""
  @Published var data: [String] = []

  @Published var searchText = ""

  @Published private(set) var phase: SearchPhase = .idle

  private let client = NetworkClient()
  private var cancellables = Set<AnyCancellable>()
  private let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!

  init() {
    bind()
  }

  func bind() {
    $searchText
      .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
      .removeDuplicates()
      .map { query -> AnyPublisher<SearchPhase,Never> in
        guard !query.isEmpty else { return Just(.idle).eraseToAnyPublisher() }
        let results: [String] = self.data.filter({ $0.contains(query) })
        return results.isEmpty ?
          Just(.empty).eraseToAnyPublisher() :
          Just(.results(results)).eraseToAnyPublisher()
      }
      .switchToLatest()
      .receive(on: RunLoop.main)
      .sink { [weak self] phase in
        self?.phase = phase
      }
      .store(in: &cancellables)
  }

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
