//
//  ModalViewController.swift
//  ModalPresentation
//
//  Created by Jungman Bae on 8/28/25.
//

import UIKit

class ModalViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
    view.backgroundColor = .systemGray

    let navBar = UINavigationBar()
    navBar.translatesAutoresizingMaskIntoConstraints = false

    let navItem = UINavigationItem(title: "새 항목 추가")
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
  }

  @objc func cancelTapped() {
    dismiss(animated: true)
  }

  @objc func saveTapped() {
//    TODO: 데이터 전달 또는 저장
    dismiss(animated: true)
  }



}
