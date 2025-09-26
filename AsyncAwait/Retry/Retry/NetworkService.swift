// NetworkService.swift
import Foundation

final class NetworkService {

  enum NetworkError: LocalizedError {
    case serverError
    case offline

    var errorDescription: String? {
      switch self {
      case .serverError:
        return "서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요."
      case .offline:
        return "네트워크에 연결되어 있지 않습니다."
      }
    }
  }

  // 더미 네트워크 호출: 1초 대기 후 랜덤으로 성공/실패
  func updateProfile() async throws {
    try await Task.sleep(nanoseconds: 1_000_000_000) // 1초

    // 랜덤 실패 시나리오
    let outcomes: [Result<Void, NetworkError>] = [
      .success(()),
      .failure(.serverError),
      .failure(.offline),
      .success(())
    ]
    if case let .failure(error) = outcomes.randomElement() ?? .success(()) {
      throw error
    }
  }
}
