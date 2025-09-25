//
//  FileManager.swift
//  Memo
//
//  Created by Jungman Bae on 9/25/25.
//

import Foundation

extension FileManager {
  func saveData(_ data: Data, to filename: String) async throws {
    let documentPath = Self.default.urls(
      for: .documentDirectory,
      in: .userDomainMask
    )[0] // iOS 문서 내 샌드박스 폴더

    let fileURL = documentPath.appendingPathComponent(filename)

    try await withCheckedThrowingContinuation { continuation in
      DispatchQueue.global(qos: .background).async {
        do {
          try data.write(to: fileURL)
          continuation.resume()
        } catch {
          continuation.resume(throwing: error)
        }
      }

    }
  }

  func loadData(from filename: String) async throws -> Data {
    let documentPath = Self.default.urls(
      for: .documentDirectory,
      in: .userDomainMask
    )[0]

    let fileURL = documentPath.appendingPathComponent(filename)

    return try await withCheckedThrowingContinuation { continuation in
      DispatchQueue.global(qos: .background).async {
        do {
          let data = try Data(contentsOf: fileURL)
          continuation.resume(returning: data)
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
