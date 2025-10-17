//
//  ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/15/25.
//
import Combine

extension MenuList {

  class ViewModel: ObservableObject {
    @Published private(set) var sections: Result<[MenuSection], Error> = .success([])

    let menuFetching: MenuFetching
    let menuGrouping: ([MenuItem]) -> [MenuSection]

    private var cancellables = Set<AnyCancellable>()

    init(
      menuFetching: MenuFetching,
      menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        self.menuFetching = menuFetching
        self.menuGrouping = menuGrouping
        fetchMenu()
      }

    func fetchMenu() {
      menuFetching
        .fetchMenu()
        .sink(receiveCompletion: { _ in },
              receiveValue: { [weak self] value in
          guard let self = self else { return }
          self.sections = .success(self.menuGrouping(value))
        })
        .store(in: &cancellables)

    }
  }
}
