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

  @Test("메뉴를 불러오기 시작할 때, 빈 메뉴를 발행")
  func test2() {
    let viewModel = MenuList.ViewModel(menu: [.fixture()])

    #expect(viewModel.sections.isEmpty)
  }

  @Test("메뉴 불러오기 성공 후, 받은 메뉴로 구성된 메뉴 섹션을 발행")
  func test3() {

  }

  @Test("메뉴 불러오기 실패 후, 에러를 발행")
  func test4() {

  }
}
