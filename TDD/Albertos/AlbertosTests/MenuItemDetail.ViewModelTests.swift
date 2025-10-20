//
//  MenuItemDetail.ViewModelTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/20/25.
//
@testable import Albertos
import Testing

struct MenuItemDetail_ViewModelTests {
  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있을때, 삭제 버튼이 노출")
  func test1() {
    let item = MenuItem.fixture()
    let orderController = OrderController()
    orderController.addToOrder(item: item)

    let viewModel = MenuItemDetail.ViewModel(
      item: item,
      orderController: orderController
    )

    let text = viewModel.addOrRemoveFromOrderButtonText
    #expect(text == "Remove from Order")
  }

  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있지 않을떄, 추가 버튼이 노출")
  func test2() {}

  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있을때, 버튼 액션은 삭제")
  func test3() {}

  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있지 않을떄, 버튼 액션은 추가")
  func test4() {}
}
