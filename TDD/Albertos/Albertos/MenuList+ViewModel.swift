//
//  ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/15/25.
//
import Combine

extension MenuList {
  class ViewModel: ObservableObject {
    @Published private(set) var sections: [MenuSection]

    init(
      menuFetching: MenuFetching = MenuFetchingPlaceholder(),
      menuGrouping: @escaping ([MenuItem]) -> [MenuSection] = groupMenuByCategory) {
        self.sections = menuGrouping([])
      }
  }
}
