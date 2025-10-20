//
//  OrderDetail.ViewModelTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/20/25.
//
@testable import Albertos

import Testing
import Combine

@Suite("OrderDetail ViewModel 테스트")
@MainActor
struct OrderDetail_ViewModelTests {
  @Test("초기 주문은 항목이 비어있음")
  func test1() {
    let orderController = OrderController()
    let sut = OrderDetail.ViewModel(orderController: orderController)

    #expect(sut.orderItems.isEmpty)
  }

  @Test("초기 주문 총액은 0")
  func test2() {
    let orderController = OrderController()
    let sut = OrderDetail.ViewModel(orderController: orderController)

    #expect(sut.orderTotal == 0.0)
  }

  @Test("주문 추가시 항목이 업데이트 되어야 함")
  func test3() {
    let orderController = OrderController()
    let sut = OrderDetail.ViewModel(orderController: orderController)
    let item = MenuItem.fixture()
    orderController.addToOrder(item: item)

    #expect(sut.orderItems.count == 1)
    #expect(sut.orderItems.first?.name == "name")
  }

  @Test("주문 제거 시 항목이 업데이트 되어야 함")
  func test4() {
    let orderController = OrderController()
    let sut = OrderDetail.ViewModel(orderController: orderController)
    let item = MenuItem.fixture()
    let item2 = MenuItem.fixture(name: "name 2")
    orderController.addToOrder(item: item)
    orderController.addToOrder(item: item2)

    orderController.removeFromOrder(item: item)

    #expect(sut.orderItems.count == 1)
    #expect(sut.orderItems.first == item2)
  }

  @Test("여러 항목이 추가되었을떄, 총액이 올바르게 계산")
  func test5() {
    let orderController = OrderController()
    let sut = OrderDetail.ViewModel(orderController: orderController)

    let item = MenuItem.fixture(price: 1.0)
    let item2 = MenuItem.fixture(name: "name 2", price: 2.0)
    let item3 = MenuItem.fixture(name: "name 3", price: 3.0)

    orderController.addToOrder(item: item)
    orderController.addToOrder(item: item2)
    orderController.addToOrder(item: item3)

    #expect(sut.orderItems.count == 3)
    #expect(sut.orderTotal == (1.0 + 2.0 + 3.0))
  }
}
