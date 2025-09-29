//
//  ViewController.swift
//  Counter
//
//  Created by Jungman Bae on 9/29/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
  @IBOutlet weak var countLabel: UILabel!
  @IBOutlet weak var incrementButton: UIButton!

  private var count = CurrentValueSubject<Int, Never>(0)
  private var cancellables = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
  }

  private func setupBindings() {
    count
      .map { "카운트: \($0)" }
      .assign(to: \.text, on: countLabel)
      .store(in: &cancellables)

    incrementButton.publisher
      .sink { [weak self] event in
        print("event: \(event.debugDescription)")
        let currentValue = self?.count.value ?? 0
        self?.count.send(currentValue + 1)
      }
      .store(in: &cancellables)
  }
}

