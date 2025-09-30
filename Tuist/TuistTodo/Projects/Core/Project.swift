import ProjectDescription

let project = Project(
  name: "Core",
  targets: [
    .target(
      name: "Core",
      destinations: .iOS,
      product: .framework,
      bundleId: "co.kr.codegrove.TuistTodo.Core",
      buildableFolders: [
        "Sources",
      ],
      dependencies: [

      ]
    )
  ],
)
