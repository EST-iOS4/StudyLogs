//
//  OrderDetail.ViewModelTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/20/25.
//
@testable import Albertos

import Testing
import Combine

extension OrderDetail.ViewModel {
  @MainActor
  func waitForAlert(timeout: Duration = .seconds(2)) async throws {
    let startTime = ContinuousClock.now

    while alertToShow == nil {
      if ContinuousClock.now - startTime > timeout {
        Issue.record("Alert이 \(timeout) 안에 표시되지 않음")
        throw TestError(id: -1)
      }
      try await Task.sleep(for: .milliseconds(10))
    }
  }
}

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

  @Test("체크아웃 버튼을 누르면, 결제 프로세스에 진입하는 확인")
  func test6() {
    let orderController = OrderController()
    orderController.addToOrder(item: .fixture(name:"name"))
    orderController.addToOrder(item: .fixture(name:"other name"))

    let paymentProcessingSpy = PaymentProcessingSpy()
    let viewModel = OrderDetail.ViewModel(
      orderController: orderController,
      paymentProcessor: paymentProcessingSpy
    )

    viewModel.checkout()

    #expect(paymentProcessingSpy.receivedOrder == orderController.order)
  }

  @Test("결제 성공시 확인 알림창 표시")
  func test7() async throws {
    let viewModel = OrderDetail.ViewModel(
      orderController: OrderController(),
      paymentProcessor: PaymentProcessingStub(
        returning: .success(())
      )
    )
    viewModel.checkout()
    try await viewModel.waitForAlert()

    #expect(viewModel.alertToShow?.title == "성공")
    #expect(viewModel.alertToShow?.message == "The payment was successful. Your food will be with you shortly.")
    #expect(viewModel.alertToShow?.buttonText == "OK")

  }

  @Test("결제 실패시 오류 알림창 표시")
  func test8() async throws {
    let viewModel = OrderDetail.ViewModel(
      orderController: OrderController(),
      paymentProcessor: PaymentProcessingStub(
        returning: .failure(TestError(id: 123))
      )
    )
    viewModel.checkout()
    try await viewModel.waitForAlert()

    #expect(viewModel.alertToShow?.title == "실패")
    #expect(viewModel.alertToShow?.message == "There's been an error with your order. Please contact a waiter.")
    #expect(viewModel.alertToShow?.buttonText == "OK")
  }
}
