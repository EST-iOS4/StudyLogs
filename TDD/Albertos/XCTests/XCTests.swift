//
//  XCTests.swift
//  XCTests
//
//  Created by Jungman Bae on 10/15/25.
//

import XCTest
@testable import Albertos
import Combine

extension MenuItem {
  static func fixture(
    category: String = "category",
    name: String = "name",
    spicy: Bool = false
  ) -> MenuItem {
    MenuItem(category: category, name: name, spicy: spicy)
  }
}

extension MenuSection {
  static func fixture(
    category: String = "category",
    items: [MenuItem] = [.fixture()]
  ) -> MenuSection {
    MenuSection(category: category, items: items)
  }
}

final class XCTests: XCTestCase {

  @MainActor
  func testWhenFetchingSucceedsPublishesSectionsBuiltFromReceivedMenu() {
    var cancellables = Set<AnyCancellable>();
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

    // Assert
    let expectation = XCTestExpectation(description: "Publishes sections...")
    viewModel.$sections
      .dropFirst()
      .sink { value in
        XCTAssertEqual(receivedMenu, menu)
        XCTAssertEqual(value, expectedSections)
        expectation.fulfill()
      }
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1)
  }
}
