import ProjectDescription

let project = Project(
    name: "TuistTodo",
    targets: [
        .target(
            name: "TuistTodo",
            destinations: .iOS,
            product: .app,
            bundleId: "co.kr.TuistTodo",
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
                "TuistTodo/Sources",
                "TuistTodo/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "TuistTodoTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.TuistTodoTests",
            infoPlist: .default,
            buildableFolders: [
                "TuistTodo/Tests"
            ],
            dependencies: [.target(name: "TuistTodo")]
        ),
    ]
)
