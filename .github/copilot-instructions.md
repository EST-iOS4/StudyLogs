# StudyLogs: AI 코딩 에이전트 지침

이 저장소는 iOS 수업용 샘플들의 모음입니다. 각 상위 폴더는 독립적인 Xcode 프로젝트(또는 Playground)이며 상호 의존하지 않습니다. 아래 규칙만 지키면 바로 작업할 수 있습니다.

## 구조와 범위
- 주요 폴더: `Combine/`, `Swift Basics/`, `SwiftUI2/`, `UIKit/`, `Git/` 등. 하위에 각자 `*.xcodeproj/` 포함.
- 다른 폴더의 코드를 참조하지 말고, 해당 샘플 폴더 내부에서만 수정/추가하세요.

## 빌드/실행
- Xcode 15+ 가정(iOS 17, Swift 5.9, `@Observable` 사용 사례 존재).
- 실행 방법: 원하는 샘플의 `*.xcodeproj`를 직접 열어 Run.
- 구성 값은 xcconfig로 주입하고, `Info.plist`에서는 `$(API_KEY)` 같은 변수만 참조합니다.

## OpenWeather 샘플 패턴(Combine + SwiftUI)
- 서비스(`WeatherService.swift`):
  - API 응답 모델과 앱 모델(표현용)을 분리.
  - 파이프라인: `URLSession.dataTaskPublisher → map(data) → decode(JSON) → map(뷰모델) → receive(on: .main) → sink → store(in:)`.
  - 상태: `@Observable` 클래스로 `weather/isLoading/errorMessage` 노출, `Set<AnyCancellable>` 보유.
- 뷰(`WeatherView.swift`): 로딩/성공/에러 3-상태 UI 분기, `onAppear`와 버튼에서 `fetchWeather()` 호출.
- 요청 관례: OpenWeather에는 `units=metric&lang=kr`를 명시해 섭씨/한글 설명 사용.

## 구성/비밀키
- 예시 파일: `OpenWeather/Debug.xcconfig`, `OpenWeather/Release.xcconfig`(빈 값 유지).
- 원칙: 비밀은 VCS에 올리지 않습니다. 필요하면 로컬 `Local.xcconfig`를 만들어 체인에 포함하고, `Info.plist`는 변수만 참조합니다.
- 주의: `.gitignore`가 xcconfig를 무시하도록 설정되어도 이미 추적된 파일은 제외되지 않습니다. 새 키는 로컬 비추적 파일로 관리하세요.

## 로컬 목 서버(네트워크 실습)
- 파일: `Combine/Networks/simple_server.py`
- 엔드포인트: `GET http://127.0.0.1:8080/isUserNameAvailable?userName=<name>` → `{ isAvailable: Bool, userName: String }`
- 실행(옵션):
```bash
python3 Combine/Networks/simple_server.py
```

## 프로젝트 관례 요약
- 파일 명명: 뷰 `*View.swift`, 앱 엔트리 `*App.swift`, 서비스 `*Service.swift`.
- 네트워크 호출은 서비스로 분리하고, 뷰는 상태만 구독합니다.
- Combine 사용 시 UI 업데이트 전 `receive(on: .main)` 적용, 구독은 `cancellables`에 저장.

## 커밋 메시지 가이드
- 한글 우선: 기본 언어는 한글로 작성합니다. 필요 시 괄호로 간단한 영어 병기 허용.
- 형식: `카테고리/샘플명: 변경 요약` (첫 줄은 72자 이내, 끝에 마침표 생략)
- 본문(선택): 변경 이유(왜), 주요 변경점(무엇), 영향 범위/후속 작업(어떻게/어디)을 간단히 서술.
- 예시:
  - `Combine/OpenWeather: 날씨 서비스 Combine 파이프라인 정리 및 오류 메시지 개선`
  - `SwiftUI2/Animation: 카드 플립 애니메이션 추가 (haptics 연동)`
  - `UIKit/TableView: 섹션 헤더 레이아웃 버그 수정`

## 빠른 참고(예시)
- `Combine/OpenWeather/OpenWeather/WeatherService.swift` — Combine 파이프라인/상태 관리 예시
- `Combine/OpenWeather/OpenWeather/WeatherView.swift` — 로딩/성공/에러 UI 분기 예시
- `Combine/Networks/simple_server.py` — 간단 HTTP 목 서버

## 지속적 실습 프로젝트 추가 가이드
- 카테고리 선택: 주제에 맞는 상위 폴더(`SwiftUI2/`, `UIKit/`, `Combine/`, `Swift Basics/`) 하위에 새 폴더 생성.
- 디렉터리/프로젝트 구조: `<Category>/<SampleName>/<SampleName>.xcodeproj`와 소스 폴더 `<Category>/<SampleName>/<SampleName>/`를 맞춥니다.
- 엔트리/파일 명명: `*App.swift`(앱 엔트리), 첫 화면 `*View.swift`(SwiftUI) 또는 `ViewController.swift`(UIKit). 네트워킹이 있으면 `*Service.swift`로 분리.
- 구성 템플릿: `Debug.xcconfig`/`Release.xcconfig`를 생성(또는 OpenWeather에서 복사)하고 `Info.plist`는 변수(`$(API_KEY)` 등)만 참조하도록 설정.
- 네트워크/Combine 재사용: OpenWeather의 파이프라인과 상태 패턴을 재사용하고 UI 업데이트 전 `receive(on: .main)`을 보장, 구독은 `cancellables`에 저장.
- 목 서버 활용(옵션): 사용자 이름/간단 검증 등은 `Combine/Networks/simple_server.py`를 실행해 로컬에서 확인.
- 독립성 유지: 다른 샘플의 파일/설정에 영향 주지 않도록, 변경은 해당 샘플 폴더에만 한정.

### 빠른 트러블슈팅
- 빌드 실패(키 누락): `Info.plist`의 키가 `$(...)`로만 참조되는지, `Debug.xcconfig`에 실제 값이 있는지 확인.
- 네트워크 에러: URL/파라미터(`units=metric&lang=kr`) 확인, 필요 시 목 서버로 전환해 요청 흐름만 먼저 점검.
- UI 업데이트 타이밍: Combine 체인의 마지막에 `receive(on: .main)`이 있는지 확인.

추가로 정리할 관례가 있으면 알려주세요. 특정 샘플 폴더를 지정해 주시면 해당 규칙을 더 보강하겠습니다.
