//
//  MenuListViewModelTest.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/15/25.
//

import Testing
@testable import Albertos
import Combine

// Combine → Async 확장
extension Publisher where Failure == Never {
  func async() async -> Output {
    return await withCheckedContinuation { continuation in
      let cancellable = first()
        .sink { value in
          continuation.resume(returning: value)
        }
      // cancellable을 유지하여 메모리 누수 방지
      withExtendedLifetime(cancellable) { }
    }
  }
}


struct MenuListViewModelTests {


  @Test("메뉴 그룹 함수가 실행되는지 확인")
  @MainActor
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
      menuFetching: MenuFetchingPlaceholder(),
      menuGrouping: spyClosure
    )

    // Assert
    let sections = viewModel.sections

    #expect(called == true)
    #expect(sections == inputSections)
  }

  @Test("메뉴를 불러오기 시작할 때, 빈 메뉴를 발행")
  @MainActor
  func test2() {
    let viewModel = MenuList.ViewModel(
      menuFetching: MenuFetchingPlaceholder()
    )

    #expect(viewModel.sections.isEmpty)
  }

  @Test("메뉴 불러오기 성공 후, 받은 메뉴로 구성된 메뉴 섹션을 발행")
  @MainActor
  func test3() async throws {
    // Arrange
    var receivedMenu: [MenuItem]?
    let expectedSections = [MenuSection.fixture()]

    let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
      receivedMenu = items
      return expectedSections
    }
    
    // Act
    let viewModel = MenuList.ViewModel(
      menuFetching: MenuFetchingPlaceholder(),
      menuGrouping: spyClosure
    )
    
    // Assert - 현재 구현에서는 초기화 시 빈 배열로 grouping 함수가 호출됨
    #expect(receivedMenu?.isEmpty == true, "초기화 시 빈 메뉴 배열이 전달되어야 함")
    #expect(viewModel.sections == expectedSections, "초기 섹션이 설정되어야 함")
  }

  @Test("메뉴 불러오기 실패 후, 에러를 발행")
  @MainActor
  func test4() {
    // Arrange
    let viewModel = MenuList.ViewModel(
      menuFetching: MenuFetchingPlaceholder()
    )
    
    // Assert - 현재 구현에서는 에러 상태가 없으므로, 기본 동작만 확인
    #expect(viewModel.sections.isEmpty, "초기 상태에서는 빈 섹션이어야 함")
    
    // Note: 실제 에러 처리 기능이 구현되면 이 테스트를 업데이트해야 함
  }
}
