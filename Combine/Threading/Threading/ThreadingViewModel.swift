//
//  ThreadingViewModel.swift
//  Threading
//
//  Created by Jungman Bae on 9/25/25.
//
import Foundation
import Combine

class ThreadingViewModel: ObservableObject {
  @Published var result: String = ""
  @Published var isLoading = false

  private var cancellables = Set<AnyCancellable>()

  func performHeavyWork() {
    isLoading = true

    performNetworkCall()
      // upstream(구독, 요청, 값 방출)을 백그라운드에서 수행
      .subscribe(on: DispatchQueue.global(qos: .background))
      .map { data in
        print("Processing on background: \(!Thread.isMainThread)")
        return self.processData(data)
      }
      // UI 업데이트는 메인에서
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] _ in
          print("UI Update on main: \(Thread.isMainThread)")
          self?.isLoading = false
        },
        receiveValue: { [weak self] result in
          print("UI Update on main: \(Thread.isMainThread)")
          self?.result = result
        }
      )
      .store(in: &cancellables)
  }

  private func performNetworkCall() -> AnyPublisher<Data, Never> {
    Deferred {
      Future<Data, Never> { promise in
        // subscribe(on:) 덕분에 이 클로저는 백그라운드에서 실행됨
        print("Network call on background: \(!Thread.isMainThread)")
        Thread.sleep(forTimeInterval: 5.0)
        promise(.success(Data("Heavy work completed".utf8)))
      }
    }
    .eraseToAnyPublisher()
  }

  private func processData(_ data: Data) -> String {
    // 무거운 데이터 처리 시뮬레이션
    Thread.sleep(forTimeInterval: 1.0)
    return String(data: data, encoding: .utf8) ?? ""
  }
}
