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
    { "name": "a name", "description": "description", "category": "a category", "price": 10.0,  "spicy": true },
    { "name": "another name", "description": "description", "category": "a category", "price": 10.0, "spicy": true }
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
  @Test("API 요청 1번 실패시 재시도 후 성공", .disabled("오류 수정 필요!"))
  func test4() async throws {
    let json = """
[
    { "name": "a name", "description": "description", "category": "a category", "price": 10.0,  "spicy": true }
]
"""
    let data = try #require(json.data(using: .utf8))
    let firstCallError = URLError(.networkConnectionLost)

    let menuFetcher = MenuFetcher(
      networkFetching: NetworkFetchingStub(returning: [
        .failure(firstCallError),
        .success(data)
      ])
    )

    let result: Result<[MenuItem], Error> = await withCheckedContinuation { continuation in
      var cancellable: AnyCancellable?
      var hasResumed = false

      cancellable = menuFetcher.fetchMenu()
        .handleEvents(
          receiveSubscription: { _ in
            print("🔵 구독 시작")
          },
          receiveOutput: { items in
            print("🟢 데이터 수신: \(items.count)개")
          },
          receiveCompletion: { completion in
            print("🟡 완료: \(completion)")
          }
        )
        .sink(
          receiveCompletion: { completion in
            defer { cancellable?.cancel() }

            guard !hasResumed else {
              print("⚠️ 이미 resumed")
              return
            }

            switch completion {
            case .finished:
              print("✅ Finished (값은 receiveValue에서 처리)")
            case .failure(let error):
              print("❌ 최종 실패: \(error)")
              hasResumed = true
              continuation.resume(returning: .failure(error))
            }
          },
          receiveValue: { items in
            print("📦 receiveValue: \(items.count)개")

            guard !hasResumed else {
              print("⚠️ 이미 resumed")
              return
            }

            hasResumed = true
            continuation.resume(returning: .success(items))
            cancellable?.cancel()
          }
        )
    }

    // 결과 검증
    switch result {
    case .success(let items):
      print("✅ 최종 성공! items -> \(items.count)")
      #expect(items.count == 1, "메뉴 아이템 1개 반환")
      #expect(items.first?.name == "retry success", "메뉴 이름 확인")
    case .failure(let error):
      print("❌ 최종 실패: \(error)")
      Issue.record("재시도 후 성공을 예상했으나 실패: \(error)")
    }
  }
}
