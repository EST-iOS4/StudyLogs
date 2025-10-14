//
//  TestBasicsSwiftTestings.swift
//  TestBasicsSwiftTestings
//
//  Created by Jungman Bae on 10/13/25.
//

import Testing

struct TestBasicsSwiftTestings {

  @Test("빈 제품 배열의 합은 0을 반환")
  func sumOfEmptyArrayIsZero() {
    // Arrange
    let category = "books"
    let products = [Product]()

    // Act
    let sum = sumOf(products, withCategory: category)

    // Assert
    #expect(sum == 0)
  }

  @Test("하나의 아이템의 합은 아이템의 가격을 반환")
  func sumOfOneItemIsItemPrice() {
    // Arrange
    let category = "books"
    let product = Product(category: category, price: 3)
    let products = [product]

    // Act
    let sum = sumOf(products, withCategory: category)

    // Assert
    #expect(sum == product.price)
  }

  @Test("필터링된 카테고리의 합을 반환")
  func sumIsSumOfItemsPricesForGivenCategory() {
    // Arrange
    let category = "books"
    let products = [
      Product(category: category, price: 3),
      Product(category: "movies", price: 2),
      Product(category: category, price: 1),
    ]
    let expectValue = products
      .filter{ $0.category == category }
      .reduce(0.0) { $0 + $1.price }

    // Act
    let sum = sumOf(products, withCategory: category)

    // Assert
    #expect(sum == expectValue)
  }

  @Test("4로 나누어 떨어지면 윤년")
  func evenlyDivisibleBy4IsLeap() {
    #expect(isLeap(2020))
  }

  @Test("4로 나누어 떨어지지 않으면 평년")
  func notEvenlyDivisibleBy4IsNotLeap() {
    #expect(!isLeap(2021))
  }

  @Test("100으로 나누어 떨어지는 경우 평년")
  func evenlyDivisibaleBy100IsNotLeap() {
    #expect(!isLeap(2100))
  }

  @Test("400으로 나누어 떨어지는 경우 윤년")
  func evenlyDivisibaleBy400IsLeap() {
    #expect(isLeap(2000))
  }

}
