//
//  AlbertosTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/14/25.
//

import Testing
@testable import Albertos

extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

struct AlbertosTests {

  @Test("빈 메뉴는 빈 섹션 배열 반환")
  func test1() {
    let menu = [MenuItem]()
    let sections = groupMenuByCategory(menu)

    #expect(sections.isEmpty)
  }

  @Test("단일 카테고리는 하나의 섹션만 반환")
  func test2() throws {
    let menu =  [
      MenuItem(category: "pastas", name: "name"),
      MenuItem(category: "pastas", name: "other name"),
    ]
    let sections = groupMenuByCategory(menu)

    #expect(sections.count == 1)
    let section = try #require(sections.first)
    #expect(section.items.count == 2)
    #expect(section.items.first?.name == "name")
    #expect(section.items.last?.name == "other name")
  }

  @Test("여러 카테고리는 카테고리당 하나의 섹션을 반환")
  func test3() {
    let menu =  [
      MenuItem(category: "pastas", name: "a pasta"),
      MenuItem(category: "drinks", name: "a drink"),
      MenuItem(category: "pastas", name: "another pasta"),
      MenuItem(category: "desserts", name: "a dessert")
    ]
    let sections = groupMenuByCategory(menu)

    #expect(sections.count == 3)
    #expect(sections[safe: 0]?.category == "pastas")
    #expect(sections[safe: 1]?.category == "drinks")
    #expect(sections[safe: 2]?.category == "desserts")
  }

}
