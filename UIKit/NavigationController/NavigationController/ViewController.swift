//
//  ViewController.swift
//  NavigationController
//
//  Created by Jungman Bae on 8/27/25.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    setupNavigationBar()
  }

  func setupNavigationBar() {
    title = "메인 화면"

    self.navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "gear"),
      style: .plain,
      target: self,
      action: #selector(settingsTapped)
    )

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemYellow
    appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]

    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance

  }

  @objc func settingsTapped() {
    let settingsVC = SettingsViewController()
    navigationController?.pushViewController(settingsVC, animated: true)
  }
}

#Preview {
  UINavigationController(rootViewController: ViewController())
}
