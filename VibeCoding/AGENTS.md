# Repository Guidelines

## 프로젝트 구조 및 모듈 구성

- `Tuist/Project.swift`: 프로젝트/타깃 정의, 빌드 설정.
- `Tuist/Dependencies.swift`: SPM 의존성(Firebase 등) 선언; `tuist install`로 해석.
- `Tuist/ProjectDescriptionHelpers/`: 공통 설정/타깃 헬퍼.
- `Projects/App` 및 `Projects/Features/<FeatureName>`: 모듈화된 소스 코드.
- `Shared/`: 재사용 유틸리티, 디자인 시스템, 네트워킹 레이어.
- `Resources/`: `Assets.xcassets`, 폰트, `Localizations/`, `Configs/`.
- `Tests/`, `UITests/`: 기능별로 소스 구조 미러링.

## 빌드·테스트·개발 명령

- 의존성 설치(SPM 해석): `tuist install`
- Xcode 프로젝트 생성: `tuist generate` → 생성된 워크스페이스 열기.
- 테스트: `tuist test --scheme VibeCoding`
- 빌드: `tuist build --scheme VibeCoding --destination 'platform=iOS Simulator,name=iPhone 15'`
- 보조: `tuist graph`(의존성 그래프), `tuist clean`(캐시 정리), `tuist edit`(설정 편집).

## 코딩 스타일 및 네이밍 규칙

- Swift 스타일: 스페이스 4칸, 120자 소프트 랩, 변수/함수 `lowerCamelCase`, 타입 `UpperCamelCase`.
- 접미사: `ViewController`, `ViewModel`, `Coordinator`, `Cell`.
- 강제 언래핑 지양; `guard`와 의존성 주입 사용 권장.
- 린트/포맷(있는 경우): `swiftlint`, `swiftformat` 통과 필수.

## 테스트 가이드라인

- 프레임워크: XCTest(선택적으로 Quick/Nimble).
- 구조: `Features/*`를 `Tests/*`, `UITests/*`에서 미러링.
- 네이밍: `FeatureNameTests`, 메서드 `test_WhenCondition_ThenOutcome`.
- 커버리지: 핵심 모듈 ≥80% 목표; 엣지 케이스와 비동기 흐름 포함.
- 로컬 실행: Xcode `⌘U` 또는 위 `xcodebuild test`.

## 커밋 및 PR 가이드라인

- 커밋: Conventional Commits 사용(e.g., `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`). 명령형, 명확한 스코프 권장.
- 브랜치: `feature/<short-desc>`, `fix/<ticket-id>`, `chore/<task>`.
- PR 필수 항목:
  - 목적/범위 요약 및 이슈 링크(`#123`).
  - UI 변경 시 스크린샷/GIF + 전/후 비교.
  - 테스트 플랜(단계, 기기/시뮬레이터)과 위험/롤백 전략.
  - 체크리스트: 빌드/테스트 통과, 린트/포맷 실행, 시크릿 미포함.

## 보안 및 설정 팁 (Firebase)

- Firebase 통합: `Tuist/Dependencies.swift`에 `Firebase` SPM 패키지 선언 후 `tuist install`.
- 구성 파일: 환경별 `GoogleService-Info.plist`를 `Resources/Configs/<Env>/`에 두고 타깃에 매핑.
- 시크릿/키: 코드에 하드코딩 금지. CI 시크릿, Info.plist 변수, Remote Config 활용.
- 권장: App Check 활성화, Crashlytics/Analytics 옵트인, Firestore/Storage 보안 규칙 버전관리.
- `.gitignore`: `DerivedData/`, 빌드 산출물, `xcuserdata/` 포함.

## 아키텍처 개요

- 권장: MVVM + Coordinator, 기능 우선 모듈화(Tuist Projects/Targets), 프로토콜 지향 설계.
- View는 단순하게, 비즈니스 로직은 ViewModel에, 네비게이션은 Coordinator로 분리.
