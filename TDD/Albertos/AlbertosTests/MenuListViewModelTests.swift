//
//  MenuListViewModelTest.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/15/25.
//

import Testing
@testable import Albertos

struct MenuListViewModelTests {

  @Test("메뉴 그룹 함수가 실행되는지 확인")
  func test1() {
    // Arrange
    var called = false
    let inputSections = [MenuSection.fixture()]

    let spyClosure: ([MenuItem]) -> [MenuSection] = {
      items in
      called = true
      return inputSections
    }

    // Act
    let viewModel = MenuList.ViewModel(
      menu: [.fixture()],
      menuGrouping: spyClosure
    )

    // Assert
    let sections = viewModel.sections

    #expect(called == true)
    #expect(sections == inputSections)
  }
}
