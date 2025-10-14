//
//  AlbertosTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/14/25.
//

import Testing
@testable import Albertos

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
      MenuItem(name: "name", category: "pastas"),
      MenuItem(name: "other name", category: "pastas"),
    ]
    let sections = groupMenuByCategory(menu)

    #expect(sections.count == 1)
    let section = try #require(sections.first)
    #expect(section.items.count == 2)
    #expect(section.items.first?.name == "name")
    #expect(section.items.last?.name == "other name")
  }

  @Test("여러 카테고리는 카테고리당 하나의 섹션을 반환")
  func test3() {}

}
