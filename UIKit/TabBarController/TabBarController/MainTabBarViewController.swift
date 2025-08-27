//
//  MainTabBarViewController.swift
//  TabBarController
//
//  Created by Jungman Bae on 8/27/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

      // 홈 뷰 컨트롤러 생성
      let viewController = ViewController()

      viewController.tabBarItem = UITabBarItem(
        title: "홈",
        image: UIImage(systemName: "house"),
        tag: 0
      )

      // 두번쨰 뷰 컨트롤러 생성 (기본 뷰 컨트롤러)
      let secondViewController = UIViewController()

      secondViewController.tabBarItem = UITabBarItem(
        title: "검색",
        image: UIImage(systemName: "magnifyingglass"),
        tag: 1
      )

      viewControllers = [viewController, secondViewController]
    }
}
