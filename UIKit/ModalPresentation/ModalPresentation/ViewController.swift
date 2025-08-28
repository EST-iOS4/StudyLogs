//
//  ViewController.swift
//  ModalPresentation
//
//  Created by Jungman Bae on 8/28/25.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Modal Presentaion"
    view.backgroundColor = .systemBackground

    var config = UIButton.Configuration.filled()
    config.title = "새 항목 추가"

    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    view.addSubview(button)

    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      button.widthAnchor.constraint(equalToConstant: 150),
      button.heightAnchor.constraint(equalToConstant: 50)
    ])

  }

  @objc func buttonTapped(_ sender: UIButton) {
    let modalVC = ModalViewController()
    modalVC.modalPresentationStyle = .popover

    if let popover = modalVC.popoverPresentationController {
      popover.sourceView = sender
      popover.sourceRect = sender.bounds
      popover.permittedArrowDirections = .left
    }

    present(modalVC, animated: true)
  }
}

