//
//  HelloWorldApp.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/24/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    let settings = Firestore.firestore().settings
    settings.host = "localhost:8080" // Or the IP address of your emulator host
    settings.isSSLEnabled = false // Disable SSL for emulator connection
    settings.cacheSettings = MemoryCacheSettings() // Or PersistentCacheSettings() if you need persistence

    Firestore.firestore().settings = settings

    Auth.auth().useEmulator(withHost: "localhost", port: 9099)

    return true
  }
}

@main
struct HelloWorldApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  @StateObject var authService = AuthenticationService()

  var body: some Scene {
    WindowGroup {
      if authService.isAuthenticated {
        ContentView()
          .environmentObject(authService)
      } else {
        LoginView()
          .environmentObject(authService)
      }
    }
  }
}
