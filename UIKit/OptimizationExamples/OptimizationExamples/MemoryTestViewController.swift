//
//  MemoryTestViewController.swift
//  OptimizationExamples
//
//  Created by Jungman Bae on 9/2/25.
//

import UIKit

class MemoryTestViewController: UIViewController {
  var name = "ViewController"
  var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
//    setupProblemTimer()  // 문제가 있는 타이머
//    setupFixedTimer()    // 해결된 타이머
    setupUnownedTimer()
  }


  // 🚨 문제: Strong Reference Cycle
  func setupProblemTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
      print(self.name)  // ❌ self를 강하게 참조!
                        // ViewController → Timer → Closure → ViewController (순환 참조)

      self.dismiss(animated: true)
    }
  }

  // ✅ 해결책 1: [weak self] 사용
  func setupFixedTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
      guard let self = self else { return }  // self가 nil일 수 있으므로 체크
      print(self.name)  // ✅ 안전하게 사용

      self.dismiss(animated: true)
    }
  }

  // ✅ 해결책 2: [unowned self] 사용 (self가 항상 있다고 확신할 때)
  func setupUnownedTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] timer in
      print(self.name)  // ✅ self가 항상 있다고 가정

      self.dismiss(animated: true)
    }
  }

  // 🧹 메모리 정리 (deinit에서 타이머 해제 필수!)
  deinit {
    timer?.invalidate()  // ⚠️ 이걸 꼭 해야 메모리 누수를 방지할 수 있어요!
    print("ViewController가 메모리에서 해제되었습니다")
  }

}
