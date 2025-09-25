// MemoViewModel.swift

import SwiftUI
import Combine

@MainActor
final class MemoViewModel: ObservableObject {
  @Published var text: String = ""

  private let filename: String
  private let fileManager: FileManager
  private var saveTask: Task<Void, Never>?

  init(filename: String = "memo.txt", fileManager: FileManager = .default) {
    self.filename = filename
    self.fileManager = fileManager
  }

  // 앱 시작 시(또는 View 표시 시) 메모 불러오기
  func load() async {
    do {
      let data = try await fileManager.loadData(from: filename)
      let loaded = String(decoding: data, as: UTF8.self)
      if loaded != text {
        text = loaded
      }
    } catch {
      // 파일이 아직 없으면(첫 실행 등) 무시
      if let cocoa = error as? CocoaError, cocoa.code == .fileReadNoSuchFile {
        return
      } else {
        print("Load failed: \(error)")
      }
    }
  }

  // 입력 변경 시 디바운스 저장
  func scheduleSave(debounce milliseconds: Int = 400) {
    saveTask?.cancel()
    saveTask = Task { [weak self] in
      guard let self else { return }
      try? await Task.sleep(for: .milliseconds(milliseconds))
      await self.save()
    }
  }

  // 즉시 저장하고 싶을 때 호출 가능
  func save() async {
    let data = Data(text.utf8)
    do {
      try await fileManager.saveData(data, to: filename)
    } catch {
      print("Save failed: \(error)")
    }
  }
}
