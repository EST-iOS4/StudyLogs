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

    // 탭 델리게이션 설정
    delegate = self

    // 홈 뷰 컨트롤러 생성
    let viewController = ViewController()

    viewController.tabBarItem = UITabBarItem(
      title: "홈",
      image: UIImage(systemName: "house"),
      tag: 0
    )

    // 두번쨰 뷰 컨트롤러 생성 (기본 뷰 컨트롤러)
    let secondViewController = UIViewController()
    secondViewController.title = "검색"

    secondViewController.tabBarItem = UITabBarItem(
      title: "검색",
      image: UIImage(systemName: "magnifyingglass"),
      tag: 1
    )

    viewControllers = [
      UINavigationController(rootViewController: viewController),
      UINavigationController(rootViewController: secondViewController)
    ]

    customizeTabBar()
  }

  func customizeTabBar() {
    // 탭바 외관 커스터마이징
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground

    // 선택된 아이템 색상
    appearance.stackedLayoutAppearance.selected.iconColor = .systemOrange
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemOrange]

    // 선택되지 않은 아이템 색상
    appearance.stackedLayoutAppearance.normal.iconColor = .systemGray
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray]

    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = appearance
  }
}

extension MainTabBarViewController: UITabBarControllerDelegate {

  // 탭 이동에 대한 검증
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }

  // 탭 선택시 액션
  func tabBarController(
    _ tabBarController: UITabBarController,
    didSelect viewController: UIViewController
  ) {
    if let navController = viewController as? UINavigationController,
       let controller = navController.viewControllers.first {
      print("\(controller.title ?? "") 탭이 선택 되었습니다.")
    }
  }
}

#Preview {
  MainTabBarViewController()
}
