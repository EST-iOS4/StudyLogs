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

  @MainActor
  @Test("메뉴 요청 API가 성공 했을때, 디코드된 메뉴 아이템이 발행되어야 함")
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
          defer {
            cancellable?.cancel()
          }
          continuation.resume(returning: items)
        })
    }

    #expect(items.count == 2)
    #expect(items.first?.name == "a name")
    #expect(items.last?.name == "another name")
  }

  @MainActor
  @Test("API 요청이 실패했을때, 받은 에러를 발행")
  func test2() async throws {
    let expectedError = URLError(.badServerResponse)
    let menuFetcher = MenuFetcher(
      networkFetching: NetworkFetchingStub(returning: .failure(expectedError))
    )
    let error = await withCheckedContinuation { continuation in
      var cancellable: AnyCancellable?
      cancellable = menuFetcher.fetchMenu()
        .sink(receiveCompletion: { completion in
          defer {
            cancellable?.cancel()
          }
          guard case .failure(let error) = completion else {
            Issue.record("Expected to fail")
            return
          }
          continuation.resume(returning: error as? URLError)
        }, receiveValue: { items in
          Issue.record("Expected to fail, succeeded with \(items)")
        })
    }
    #expect(error == expectedError)
  }

  @MainActor
  @Test("API 요청이 실패 했을때, 타임아웃 에러")
  func test3() async throws {
    let expectedError = URLError(.timedOut)
    let menuFetcher = MenuFetcher(
      networkFetching: NetworkFetchingStub(returning: .failure(expectedError))
    )
    let error = await withCheckedContinuation { continuation in
      var cancellable: AnyCancellable?
      cancellable = menuFetcher.fetchMenu()
        .sink(receiveCompletion: { completion in
          defer {
            cancellable?.cancel()
          }
          guard case .failure(let error) = completion else {
            Issue.record("Expected to fail")
            return
          }
          continuation.resume(returning: error as? URLError)
        }, receiveValue: { items in
          Issue.record("Expected to fail, succeeded with \(items)")
        })
    }
    #expect(error == expectedError)
  }

  @MainActor
  @Test("API 요청 1번 실패시 재시도 후 성공")
  func test4() async throws {
    let json = """
[
    { "name": "retry success", "category": "test", "spicy": false }
]
"""
    let data = try #require(json.data(using: .utf8))
    let firstCallError = URLError(.networkConnectionLost)
    
    // 첫 번째 호출은 실패, 두 번째 호출(재시도)는 성공
    let menuFetcher = MenuFetcher(
      networkFetching: NetworkFetchingStub(returning: [
        .failure(firstCallError),  // 첫 번째 요청 실패
        .success(data)             // 재시도 성공
      ])
    )
    
    let items = await withCheckedContinuation { continuation in
      var cancellable: AnyCancellable?
      cancellable = menuFetcher.fetchMenu()
        .sink(
          receiveCompletion: { completion in
            defer {
              cancellable?.cancel()
            }
            guard case .failure(let error) = completion else {
              return
            }
            Issue.record("Expected success after retry, but failed with \(error)")
          },
          receiveValue: { items in
            defer {
              cancellable?.cancel()
            }
            continuation.resume(returning: items)
          }
        )
    }
    
    #expect(items.count == 1)
    #expect(items.first?.name == "retry success")
  }
}
