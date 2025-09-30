import ProjectDescription

let project = Project(
  name: "App",
  targets: [
    .target(
      name: "App",
      destinations: .iOS,
      product: .app,
      bundleId: "co.kr.codegrove.TuistTodo",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
              "UIWindowSceneSessionRoleApplication": [
                [
                  "UISceneConfigurationName": "Default Configuration",
                  "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ]
              ]
            ]
          ]
        ]
      ),
      buildableFolders: [
        "Sources",
      ],
      dependencies: [
        .project(target: "Core", path: "../Core"),
      ]
    ),
  ]
)
