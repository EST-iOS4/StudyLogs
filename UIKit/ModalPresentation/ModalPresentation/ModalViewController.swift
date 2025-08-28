//
//  ModalViewController.swift
//  ModalPresentation
//
//  Created by Jungman Bae on 8/28/25.
//

import UIKit

protocol SendDataDelegate {
  func sendData(_ data: String)
}

class ModalViewController: UIViewController {
  let textField = UITextField()

  var data: String = ""

  var delegate: SendDataDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
    view.backgroundColor = .systemGray

    let navBar = UINavigationBar()
    navBar.translatesAutoresizingMaskIntoConstraints = false

    let navItem = UINavigationItem(title: data)
    navItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(cancelTapped)
    )
    navItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(saveTapped)
    )

    navBar.setItems([navItem], animated: false)

    view.addSubview(navBar)

    NSLayoutConstraint.activate([
      navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    textField.borderStyle = .roundedRect
    textField.backgroundColor = .systemBackground
    textField.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(textField)

    NSLayoutConstraint.activate([
      textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      textField.widthAnchor.constraint(equalToConstant: 200),
      textField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  @objc func cancelTapped() {
    dismiss(animated: true)
  }

  @objc func saveTapped() {
    delegate?.sendData(textField.text ?? "")
    dismiss(animated: true)
  }



}
