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
    #expect(text == "Remove from order")
  }

  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있지 않을떄, 추가 버튼이 노출")
  func test2() {
    let item = MenuItem.fixture()
    let orderController = OrderController()
    let viewModel = MenuItemDetail.ViewModel(
      item: item,
      orderController: orderController
    )

    let text = viewModel.addOrRemoveFromOrderButtonText
    #expect(text == "Add to order")

  }

  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있을때, 버튼 액션은 삭제")
  func test3() {
    // Arrange
    let item = MenuItem.fixture()
    let controller = OrderController()
    controller.addToOrder(item: item)

    let viewModel = MenuItemDetail.ViewModel(
      item: item,
      orderController: controller
    )

    // 삭제 이전에 메뉴 아이템을 가지고 있는지 확인
    #expect(controller.order.items.contains { $0 == item })

    // Act
    viewModel.addOrRemoveFromOrder()

    // Assert
    // 삭제 후 아이템이 삭제되었는지 확인
    #expect(!controller.order.items.contains { $0 == item })
  }

  @MainActor
  @Test("메뉴 아이템이 Order 에 들어있지 않을떄, 버튼 액션은 추가")
  func test4() {}
}
