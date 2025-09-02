//
//  AppDelegate.swift
//  OptimizationExamples
//
//  Created by Jungman Bae on 9/2/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let startTime = CFAbsoluteTimeGetCurrent()

    print("앱이 실행됩니다. \(launchOptions?.debugDescription ?? "")")

    setupEssentials()

    DispatchQueue.main.async {
      self.setupNonEssentials()
    }

    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

    print("앱 시작 시간: \(timeElapsed)초")

    return true
  }

  func setupEssentials() {
    print("포어그라운드 작업 시작")
    Thread.sleep(forTimeInterval: 1)
    print("포어그라운드 작업 종료")
  }

  func setupNonEssentials() {
    print("백그라운드 작업 시작")
    Thread.sleep(forTimeInterval: 1)
    print("백그라운드 작업 종료")
  }

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

