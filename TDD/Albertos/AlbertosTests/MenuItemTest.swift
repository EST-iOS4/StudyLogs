//
//  MenuItemTest.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/17/25.
//

@testable import Albertos
import Foundation
import Testing

struct MenuItemTest {

  @Test("JSON 데이터가 디코드되면 모든 입력속성이 잘 지정되는지 확인")
  @MainActor
  func test1() throws {
    let json = MenuItem.jsonFixture(
      name: "a name",
      category: "a category",
      spicy: false
    )

    let data = try #require(json.data(using: .utf8))
    let item = try JSONDecoder().decode(MenuItem.self, from: data)

    #expect(item.name == "a name")
    #expect(item.category == "a category")
    #expect(item.spicy == false)
  }

}
