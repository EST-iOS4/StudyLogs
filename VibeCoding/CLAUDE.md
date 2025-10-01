# CLAUDE.md

이 파일은 Claude Code(claude.ai/code)가 이 저장소의 코드 작업 시 참고하는 가이드입니다.

## 프로젝트 개요

iOS 부트캠프 최종 프로젝트로 개발되는 LLM 기반 iOS 애플리케이션입니다. AI/LLM 기능을 활용하여 지능형 iOS 앱을 구현합니다.

**기술 스택**:

- **프로젝트 관리**: Tuist 4.x
- **백엔드**: Firebase (Authentication, Firestore, Storage 등)
- **UI 프레임워크**: SwiftUI
- **의존성 관리**: Swift Package Manager (Tuist 통합)

## 개발 환경 설정

### 사전 요구사항

- Xcode 15.0 이상
- Swift 5.9+
- iOS 17.0+ 배포 타겟
- Tuist 4.x (`brew install tuist` 또는 `mise install tuist`)
- Firebase CLI (선택사항, 배포용)

### 초기 설정

```bash
# 저장소 클론
git clone <repository-url>
cd <project-directory>

# Tuist 의존성 설치 (Package.swift에 정의된 SPM 패키지)
tuist install

# Xcode 프로젝트 생성
tuist generate

# Xcode에서 프로젝트 열기
tuist edit  # Tuist 매니페스트 편집
open <AppName>.xcworkspace  # 생성된 프로젝트 열기
```

### Tuist 주요 명령어

```bash
# 프로젝트 생성
tuist generate

# 특정 타겟만 생성
tuist generate <AppName>

# 의존성 업데이트 및 프로젝트 재생성
tuist install
tuist generate

# 프로젝트 빌드
tuist build <AppName>

# 테스트 실행
tuist test <AppName>Tests

# 특정 테스트만 실행
tuist test <AppName>Tests --test-targets <AppName>Tests/TestClassName/testMethodName

# 캐시 정리
tuist clean

# 프로젝트 의존성 그래프 시각화
tuist graph

# Tuist 매니페스트 파일 편집 (Project.swift, Workspace.swift 등)
tuist edit
```

## 아키텍처 가이드라인

### LLM 통합 아키텍처

- **API 레이어**: LLM API 통신을 위한 전용 서비스 레이어
- **응답 처리**: LLM 응답의 구조화된 파싱 및 검증
- **상태 관리**: 대화 컨텍스트 및 히스토리 유지
- **에러 핸들링**: LLM 서비스 장애 시 우아한 성능 저하 처리

### Firebase 백엔드 아키텍처

- **Authentication**: Firebase Auth를 통한 사용자 인증 (이메일/소셜 로그인)
- **Firestore**: NoSQL 데이터베이스로 대화 히스토리, 사용자 프로필 저장
- **Storage**: 파일 업로드 및 저장 (이미지, 음성 등)
- **Cloud Functions**: 서버리스 백엔드 로직 (LLM API 호출, 데이터 가공 등)
- **Remote Config**: 동적 설정 및 기능 플래그

### iOS 아키텍처 패턴

- MVVM 또는 Clean Architecture 패턴 준수
- 비즈니스 로직과 UI 컴포넌트 분리
- 의존성 주입 및 테스트 가능성을 위한 프로토콜 사용
- Firebase Repository 패턴으로 데이터 영속성 구현

### 주요 아키텍처 고려사항

1. **Async/Await**: LLM API 및 Firebase 호출에 최신 Swift 동시성 사용
2. **Combine/SwiftUI**: 실시간 UI 업데이트를 위한 반응형 데이터 플로우
3. **오프라인 지원**: Firestore 오프라인 영속성, LLM 응답 캐싱
4. **보안**:
   - Keychain을 사용한 안전한 API 키 저장
   - Firebase Security Rules로 데이터 접근 제어
   - 절대 GoogleService-Info.plist를 공개 저장소에 커밋 금지

## Firebase 통합 모범 사례

### Firebase 초기 설정

```swift
// AppDelegate 또는 @main App 구조체에서 Firebase 초기화
import FirebaseCore

@main
struct YourApp: App {
    init() {
        FirebaseApp.configure()
    }
}
```

### Firestore 데이터 모델링

- 컬렉션 구조: `users/{userId}/conversations/{conversationId}/messages/{messageId}`
- 인덱스 최적화: 쿼리 패턴에 맞춘 복합 인덱스 생성
- 실시간 리스너 관리: 메모리 누수 방지를 위한 적절한 detach

### Firebase Security Rules

```javascript
// Firestore 규칙 예시
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;

      match /conversations/{conversationId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

### 환경 분리 (Dev/Prod)

- 개발용 Firebase 프로젝트와 프로덕션 Firebase 프로젝트 분리
- Tuist Config로 환경별 GoogleService-Info.plist 관리
- `.gitignore`에 `GoogleService-Info.plist` 추가 필수

## LLM 통합 모범 사례

### API 통신

- 네트워크 요청에 async/await와 URLSession 사용
- Firebase Cloud Functions를 통한 안전한 LLM API 호출 (API 키 노출 방지)
- 지수 백오프를 통한 재시도 로직 구현
- LLM 응답 시간에 적합한 타임아웃 값 설정
- LLM API에서 지원 시 스트리밍 응답 사용

### 토큰 관리

- API 한도 내에서 토큰 사용량 모니터링
- Firestore에 사용자별 토큰 사용량 추적
- 컨텍스트 윈도우 관리를 위한 대화 내역 정리 구현
- API 호출 전 토큰 수 예측

### 응답 처리

- 표시 전 LLM 응답 검증 및 정제
- Firestore에 대화 내역 저장 (오프라인 지원)
- API 실패 시 적절한 에러 메시지 구현
- Rate Limiting을 우아하게 처리
- 가능한 경우 구조화된 출력(JSON 모드) 파싱

## 테스트 전략

### 단위 테스트

- LLM 응답 파싱 및 검증 로직 테스트
- Firebase Repository 로직 테스트 (Mock Firestore 사용)
- 일관된 테스트를 위한 API 응답 모킹
- 에러 처리 및 엣지 케이스 테스트
- 토큰 카운팅 및 대화 관리 검증

### UI 테스트

- LLM 상호작용이 포함된 사용자 플로우 테스트
- Firebase 인증 플로우 테스트 (테스트용 계정 사용)
- 로딩 상태 및 에러 메시지 검증
- 오프라인 동작 및 Firestore 영속성 테스트

### 통합 테스트

- 엔드투엔드 LLM 대화 플로우 테스트
- Firebase Emulator를 사용한 로컬 테스트
- 실제(또는 스테이징) 엔드포인트와의 API 통합 검증
- 다양한 네트워크 조건에서 성능 테스트

### Firebase 테스트 설정

```bash
# Firebase Emulator Suite 설치
npm install -g firebase-tools

# Emulator 시작 (Firestore, Auth, Functions)
firebase emulators:start

# 테스트 실행 시 Emulator에 연결
# XCTest 환경변수 설정: USE_FIREBASE_EMULATOR=true
```

## 코드 구조

### Tuist 프로젝트 구조

```bash
<ProjectRoot>/
├── Tuist/
│   ├── Config.swift              # Tuist 전역 설정
│   ├── ProjectDescriptionHelpers/ # 재사용 가능한 헬퍼
│   └── Dependencies.swift        # 외부 의존성 정의
├── Project.swift                 # 프로젝트 매니페스트
├── Workspace.swift               # 워크스페이스 정의 (선택사항)
├── Derived/                      # Tuist 생성 파일 (gitignore)
├── Projects/
│   └── <AppName>/
│       ├── Project.swift         # 앱 타겟 정의
│       ├── Sources/
│       │   ├── App/             # 앱 진입점, 라이프사이클
│       │   │   ├── <AppName>App.swift
│       │   │   └── AppDelegate.swift
│       │   ├── Features/        # 기능별 모듈
│       │   │   ├── Authentication/
│       │   │   │   ├── Views/
│       │   │   │   ├── ViewModels/
│       │   │   │   └── Models/
│       │   │   ├── Chat/
│       │   │   │   ├── Views/
│       │   │   │   ├── ViewModels/
│       │   │   │   └── Models/
│       │   │   └── Profile/
│       │   ├── Services/        # 비즈니스 로직 서비스
│       │   │   ├── LLM/         # LLM API 통신
│       │   │   ├── Firebase/    # Firebase 서비스
│       │   │   │   ├── AuthService.swift
│       │   │   │   ├── FirestoreService.swift
│       │   │   │   └── StorageService.swift
│       │   │   └── Network/     # 네트워크 레이어
│       │   ├── Core/            # 공통 유틸리티
│       │   │   ├── Extensions/
│       │   │   ├── Utilities/
│       │   │   └── Constants/
│       │   └── Resources/       # 리소스 파일
│       │       ├── Assets.xcassets
│       │       ├── Fonts/
│       │       └── Localization/
│       ├── Tests/               # 유닛 테스트
│       ├── UITests/             # UI 테스트
│       └── Resources/
│           └── GoogleService-Info.plist  # Firebase 설정 (gitignore!)
└── .gitignore
```

### Tuist Project.swift 예시

```swift
import ProjectDescription

let project = Project(
    name: "<AppName>",
    targets: [
        Target(
            name: "<AppName>",
            platform: .iOS,
            product: .app,
            bundleId: "com.yourteam.<appname>",
            deploymentTarget: .iOS(targetVersion: "17.0", devices: .iphone),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:],
                "CFBundleDisplayName": "<DisplayName>"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .external(name: "FirebaseAuth"),
                .external(name: "FirebaseFirestore"),
                .external(name: "FirebaseStorage"),
                .external(name: "FirebaseAnalytics")
            ]
        ),
        Target(
            name: "<AppName>Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.yourteam.<appname>.tests",
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "<AppName>")
            ]
        )
    ]
)
```

## 개발 워크플로우

### Git 워크플로우

- `main` 브랜치에서 기능 브랜치 생성
- 영어로 설명적인 커밋 메시지 작성
- Conventional Commits 형식 준수: `feat:`, `fix:`, `refactor:` 등
- 집중적이고 원자적인 커밋 유지

### 코드 리뷰 체크리스트

- LLM API 키가 하드코딩되지 않았는지 확인
- GoogleService-Info.plist가 커밋되지 않았는지 확인
- Firebase Security Rules가 적절히 설정되었는지 확인
- 에러 상태가 적절히 처리되는지 확인 (Firebase, LLM 모두)
- 로딩 상태가 사용자 피드백을 제공하는지 확인
- LLM/Firebase 호출 중에도 UI가 반응성을 유지하는지 확인
- 메모리 관리가 적절한지 확인 (순환 참조, Firestore 리스너 해제 등)
- Firestore 쿼리 최적화 및 인덱스 사용 확인

## 성능 고려사항

### LLM 관련 최적화

- 자주 요청되는 LLM 응답 Firestore/로컬 캐싱
- API 호출 전 사용자 입력 디바운싱
- 긴 형식의 콘텐츠 생성 시 스트리밍 사용
- 중단된 쿼리에 대한 요청 취소 구현

### Firebase 관련 최적화

- **Firestore**:
  - 복합 쿼리에 인덱스 생성
  - 페이지네이션으로 대량 데이터 로딩 방지
  - 오프라인 영속성 활성화로 네트워크 요청 최소화
  - 실시간 리스너를 필요한 곳에만 사용
- **Storage**:
  - 이미지 업로드 전 압축 및 리사이징
  - 썸네일 버전 생성으로 대역폭 절약
- **Authentication**:
  - Auth 상태 변경 리스너 최소화
  - 토큰 캐싱 및 자동 갱신 활용

### iOS 관련 최적화

- 뷰와 데이터 지연 로딩
- 효율적인 LazyVStack/LazyVGrid 패턴 사용
- AsyncImage 또는 Kingfisher로 이미지 로딩 최적화
- Instruments로 메모리 사용량 및 Firestore 쿼리 모니터링

## 디버깅

### 일반적인 문제

- **Firebase 초기화 실패**: GoogleService-Info.plist 경로 및 내용 확인
- **인증 오류**: Firebase Console에서 인증 방법 활성화 확인
- **Firestore 권한 오류**: Security Rules 검토 및 사용자 인증 상태 확인
- **API 키 문제**: Keychain 저장 및 검색 확인
- **느린 응답**: 네트워크 조건, Firestore 쿼리 최적화, 타임아웃 설정 확인
- **토큰 한도 오류**: 대화 히스토리 정리 로직 검토
- **UI 프리징**: LLM/Firebase 호출이 백그라운드 스레드에서 실행되는지 확인
- **Firestore 리스너 메모리 누수**: 리스너 해제(detach) 확인

### 디버깅 도구

```bash
# 콘솔 로그 확인 (Firebase 로그 포함)
xcrun simctl spawn booted log stream --predicate 'process == "<AppName>"'

# Firebase 디버그 로깅 활성화
# Xcode Scheme > Run > Arguments > -FIRDebugEnabled

# 메모리 프로파일링
instruments -t Allocations -D <output.trace> <AppName>.app

# 네트워크 디버깅
# LLM API 및 Firebase 검사를 위해 Charles Proxy 또는 Proxyman 사용

# Firebase Emulator 실행
firebase emulators:start --only firestore,auth
```

### Firebase 디버깅 팁

```swift
// Firestore 디버그 로깅
let settings = Firestore.firestore().settings
settings.isSSLEnabled = true
Firestore.firestore().settings = settings

// Firebase Auth 상태 디버깅
Auth.auth().addStateDidChangeListener { auth, user in
    print("Auth state changed: \(user?.uid ?? "nil")")
}
```

## 의존성 관리

### Tuist Dependencies.swift

Tuist를 사용하여 SPM 패키지를 관리합니다.

```swift
// Tuist/Dependencies.swift
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk",
            requirement: .upToNextMajor(from: "10.0.0")
        )
    ],
    platforms: [.iOS]
)
```

### 새 의존성 추가 워크플로우

```bash
# 1. Tuist/Dependencies.swift에 패키지 추가
# 2. 의존성 해결 및 설치
tuist install

# 3. Project.swift에서 타겟에 의존성 추가
# dependencies: [
#     .external(name: "FirebaseAuth"),
#     .external(name: "FirebaseFirestore")
# ]

# 4. 프로젝트 재생성
tuist generate

# 5. 빌드 및 테스트
tuist build
tuist test
```

### 주요 의존성

- **Firebase SDK**: Authentication, Firestore, Storage, Analytics
- **LLM SDK**: OpenAI SDK, Anthropic SDK 등 (선택)
- 각 의존성에 대한 이유 문서화
- 재현성 보장을 위한 버전 고정
- 보안 패치를 위한 정기적인 의존성 업데이트

### LLM SDK 통합

- OpenAI SDK, Anthropic SDK 사용 시 Tuist Dependencies에 추가
- API 버전 호환성 문서화
- 최신 기능을 위한 SDK 업데이트 유지
- SDK 업데이트 후 `tuist generate` 재실행 및 철저한 테스트

## 지역화

- 한국어를 주 언어로 사용
- 가능한 경우 한국어와 영어 모두 지원
- 모든 사용자 대면 텍스트에 `NSLocalizedString` 사용
- 특별히 한국어를 타겟하지 않는 한 LLM 프롬프트는 영어로 일관성 유지

## 접근성

- LLM 생성 콘텐츠에 대한 VoiceOver 지원
- Dynamic Type 호환성 보장
- 생성된 이미지에 대한 대체 텍스트 제공
- Accessibility Inspector로 테스트

## 중요 사항

### 보안 및 개인정보

- **Firebase 설정 파일**:
  - `.gitignore`에 `GoogleService-Info.plist` 추가 필수
  - 민감 정보는 환경변수 또는 Keychain에 저장
  - Firebase Security Rules로 데이터 접근 제어
- **LLM API 키**:
  - 클라이언트에 API 키 노출 금지
  - Firebase Cloud Functions를 통한 서버 측 API 호출 권장
  - Keychain을 사용한 안전한 저장
- **개인정보 보호**:
  - iOS 개인정보 보호 가이드라인 준수
  - Firebase Analytics 사용 시 사용자 동의 획득
  - 사용자 데이터 암호화 및 안전한 전송

### 비용 관리

- **Firebase 무료 한도**:
  - Firestore: 50,000 읽기/20,000 쓰기/일
  - Storage: 5GB 저장공간, 1GB 다운로드/일
  - Authentication: 무제한 (대부분의 경우)
- **LLM API 비용**: 개발 중 토큰 사용량 모니터링
- **Firebase Quota 알림**: Console에서 사용량 알림 설정 권장

### 앱 스토어 심사

- **LLM 사용**: App Store 심사 가이드라인 준수 확인
  - 생성된 콘텐츠에 대한 적절한 필터링 및 모니터링
  - 유해 콘텐츠 차단 메커니즘 구현
- **Firebase Analytics**:
  - 개인정보 처리방침 명시
  - 사용자 동의 메커니즘 구현
- **Rate Limiting**: API 스로틀링 방지를 위한 적절한 제한 구현

### 개발 환경 분리

```swift
// Config.swift - 환경별 설정
enum Environment {
    case development
    case staging
    case production

    static var current: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }

    var firebaseConfigFileName: String {
        switch self {
        case .development:
            return "GoogleService-Info-Dev"
        case .staging:
            return "GoogleService-Info-Staging"
        case .production:
            return "GoogleService-Info"
        }
    }
}
```
