//
//  MenuFetcherTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 10/20/25.
//
@testable import Albertos
import Testing
import Combine
import Foundation

struct MenuFetcherTests {

  @Test("메뉴 요청 API가 성공 했을때, 디코드된 메뉴 아이템이 발행되어야 함")
  @MainActor
  func test1() async throws {
    let json = """
[
    { "name": "a name", "category": "a category", "spicy": true },
    { "name": "another name", "category": "a category", "spicy": true }
]
"""
    let data = try #require(json.data(using: .utf8))
    let menuFetcher = MenuFetcher(networkFetching: NetworkFetchingStub(returning: .success(data)))

    let items = await withCheckedContinuation { continuation in
      var cancellable: AnyCancellable?
      cancellable = menuFetcher.fetchMenu()
        .sink(receiveCompletion: { _ in }, receiveValue: {
          items in
          continuation.resume(returning: items)
          cancellable?.cancel()
        })
    }

    #expect(items.count == 2)
    #expect(items.first?.name == "a name")
    #expect(items.last?.name == "another name")
  }

}
