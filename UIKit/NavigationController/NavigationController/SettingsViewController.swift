//
//  SettingsViewController.swift
//  NavigationController
//
//  Created by Jungman Bae on 8/27/25.
//

import UIKit

class SettingsViewController: UIViewController {
  // 임시 데이터 (저장 여부)
  var hasUnsavedChanges = false

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Settings"
    view.backgroundColor = .systemBackground

    setupNavigationItems()
  }

  func setupNavigationItems() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "닫기",
      style: .plain,
      target: self,
      action: #selector(customBackAction)
    )
  }

  @objc func customBackAction() {
    if hasUnsavedChanges {
      showSaveAlert()
    } else {
      navigationController?.popViewController(animated: true)
    }
  }

  func showSaveAlert() {
    
  }
}

#Preview {
  let viewController = ViewController()
  let navigationController = UINavigationController(
    rootViewController: viewController)
  navigationController.pushViewController(SettingsViewController(),
                                          animated: false)
  viewController.setupNavigationBar()
  return navigationController
}
