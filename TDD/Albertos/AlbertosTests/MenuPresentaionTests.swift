//
//  MenuPresentaionTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/14/25.
//

import Testing
@testable import Albertos

struct MenuPresentaionTests {
  let carbonara = MenuItem.fixture(
    category: "pasta",
    name: "Carbonara",
    spicy: false
  )
  let arrabiata = MenuItem.fixture(
    category: "pasta",
    name: "Arrabiata",
    spicy: true
  )
  let margherita = MenuItem.fixture(
    category: "pasta",
    name: "Margherita",
    spicy: false
  )

  @Test("전체 메뉴 표시")
  func test1() {
    let presentation = MenuPresentation(
      allItems: [carbonara, arrabiata, margherita],
      showOnlySpicy: false
    )

    #expect(presentation.displayedItems.count == 3)
  }

  @Test("매운 메뉴만 표시")
  func test2() {
    let presentation = MenuPresentation(
      allItems: [carbonara, arrabiata, margherita],
      showOnlySpicy: true
    )

    #expect(presentation.displayedItems.count == 1)
    #expect(presentation.displayedItems[safe: 0]?.name == "Arrabiata")
  }

  @Test("매운 메뉴가 없을 때 빈 상태 메세지")
  func test3() {
    let presentation = MenuPresentation(
      allItems: [carbonara, margherita],
      showOnlySpicy: true
    )

    #expect(presentation.emptyStateMessage == "매운 메뉴가 없습니다.")
  }

  @Test("필터 꺼져있을 때 빈 상태 메시지 없음")
  func test4() {
    let presentation = MenuPresentation(
      allItems: [],
      showOnlySpicy: false
    )

    #expect(presentation.emptyStateMessage == nil)
  }

  @Test("맵지 않은 메뉴명은 이름만 출력")
  func test5() {
    let item = MenuItem.fixture(name: "name", spicy: false)
    let viewModel = MenuRow.ViewModel(item: item)

    #expect(viewModel.text == "name")
  }

  @Test("매운 메뉴는 이름과 불 이모지를 출력")
  func test6() {
    let item = MenuItem.fixture(name: "name", spicy: true)
    let viewModel = MenuRow.ViewModel(item: item)

    #expect(viewModel.text == "name 🔥")
  }
}
