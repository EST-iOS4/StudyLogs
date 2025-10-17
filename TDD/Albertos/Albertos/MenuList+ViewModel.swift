//
//  ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/15/25.
//
import Combine

extension MenuList {

  @MainActor
  class ViewModel: ObservableObject {
    @Published private(set) var sections: [MenuSection]

    private var cancellables = Set<AnyCancellable>()

    init(
      menuFetching: MenuFetching,
      menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        sections = []
        menuFetching
          .fetchMenu()
          .sink(receiveCompletion: { _ in },
                receiveValue: { [weak self] value in
            self?.sections = menuGrouping(value)
          })
          .store(in: &cancellables)
      }
  }
}
