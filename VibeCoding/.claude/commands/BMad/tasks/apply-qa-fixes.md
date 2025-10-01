# /apply-qa-fixes Task

When this command is used, execute the following task:

<!-- Powered by BMAD™ Core -->

# QA 수정사항 적용

특정 스토리에 대한 QA 결과(게이트 및 평가)를 기반으로 수정사항을 구현합니다. 이 태스크는 Dev 에이전트가 QA 출력물을 체계적으로 분석하고 코드/테스트 변경사항을 적용하면서 스토리 파일의 허용된 섹션만 업데이트하도록 합니다.

## 목적

- 스토리에 대한 QA 출력물 읽기(게이트 YAML + 평가 마크다운)
- 우선순위가 정해진 결정론적 수정 계획 생성
- 격차를 줄이고 문제를 해결하기 위한 코드 및 테스트 변경사항 적용
- Dev 에이전트에 대한 허용된 스토리 섹션만 업데이트

## 입력값

```yaml
required:
  - story_id: '{epic}.{story}' # 예: "2.2"
  - qa_root: `bmad-core/core-config.yaml`의 `qa.qaLocation` 키에서 (예: `docs/project/qa`)
  - story_root: `bmad-core/core-config.yaml`의 `devStoryLocation` 키에서 (예: `docs/project/stories`)

optional:
  - story_title: '{title}' # 누락 시 스토리 H1에서 도출
  - story_slug: '{slug}' # 누락 시 제목에서 도출(소문자, 하이픈으로 연결)
```

## 읽어야 할 QA 소스

- 게이트(YAML): `{qa_root}/gates/{epic}.{story}-*.yml`
  - 여러 개가 있는 경우, 수정 시간 기준으로 가장 최근 것 사용
- 평가(마크다운):
  - 테스트 설계: `{qa_root}/assessments/{epic}.{story}-test-design-*.md`
  - 추적성: `{qa_root}/assessments/{epic}.{story}-trace-*.md`
  - 위험 프로파일: `{qa_root}/assessments/{epic}.{story}-risk-*.md`
  - NFR 평가: `{qa_root}/assessments/{epic}.{story}-nfr-*.md`

## 전제조건

- 저장소가 로컬에서 빌드되고 테스트가 실행됨(Deno 2)
- 린트 및 테스트 명령 사용 가능:
  - `deno lint`
  - `deno test -A`

## 프로세스 (단계 건너뛰지 말 것)

### 0) 핵심 구성 로드 및 스토리 위치 확인

- `bmad-core/core-config.yaml`을 읽고 `qa_root`와 `story_root`를 해결
- `{story_root}/{epic}.{story}.*.md`에서 스토리 파일 위치 확인
  - 누락된 경우 중단하고 올바른 스토리 id/경로 요청

### 1) QA 결과 수집

- 최신 게이트 YAML 파싱:
  - `gate` (PASS|CONCERNS|FAIL|WAIVED)
  - `id`, `severity`, `finding`, `suggested_action`이 포함된 `top_issues[]`
  - `nfr_validation.*.status` 및 메모
  - `trace` 커버리지 요약/격차
  - `test_design.coverage_gaps[]`
  - `risk_summary.recommendations.must_fix[]` (있는 경우)
- 존재하는 평가 마크다운을 읽고 명시적 격차/권장사항 추출

### 2) 결정론적 수정 계획 구축 (우선순위 순서)

우선순위가 높은 것부터 순서대로 적용:

1. `top_issues`의 높은 심각도 항목(보안/성능/신뢰성/유지보수성)
2. NFR 상태: 모든 FAIL은 수정 필요 → 그 다음 CONCERNS
3. 테스트 설계 `coverage_gaps` (지정된 경우 P0 시나리오 우선순위)
4. 추적되지 않은 요구사항(AC 수준)
5. 위험 `must_fix` 권장사항
6. 중간 심각도 문제, 그 다음 낮은 심각도

지침:

- 코드 변경 전/과 함께 커버리지 격차를 닫는 테스트 우선
- 변경사항을 최소화하고 목적에 집중; 프로젝트 아키텍처 및 TS/Deno 규칙 준수

### 3) 변경사항 적용

- 계획에 따른 코드 수정 구현
- 커버리지 격차를 닫기 위한 누락된 테스트 추가(단위 테스트 우선; AC에서 요구하는 경우 통합 테스트)
- `deps.ts`를 통한 중앙집중식 임포트 유지(`docs/project/typescript-rules.md` 참조)
- `src/core/di.ts`의 DI 경계 및 기존 패턴 준수

### 4) 검증

- `deno lint` 실행 및 문제 수정
- 모든 테스트가 통과할 때까지 `deno test -A` 실행
- 깨끗해질 때까지 반복

### 5) 스토리 업데이트 (허용된 섹션만)

중요: Dev 에이전트는 스토리 파일의 다음 섹션만 업데이트할 권한이 있습니다. 다른 섹션(예: QA 결과, 스토리, 인수 기준, 개발 노트, 테스팅)은 수정하지 마세요:

- 태스크 / 하위태스크 체크박스 (추가한 수정 하위태스크를 완료로 표시)
- Dev Agent Record →
  - Agent Model Used (변경된 경우)
  - Debug Log References (명령/결과, 예: lint/tests)
  - Completion Notes List (무엇이 변경되었는지, 왜, 어떻게)
  - File List (추가/수정/삭제된 모든 파일)
- Change Log (적용된 수정사항을 설명하는 새 날짜 항목)
- Status (아래 규칙 참조)

상태 규칙:

- 게이트가 PASS이고 식별된 모든 격차가 해결된 경우 → `Status: Ready for Done` 설정
- 그렇지 않은 경우 → `Status: Ready for Review` 설정하고 QA에 재검토 실행 알림

### 6) 게이트 파일 편집 금지

- Dev는 게이트 YAML을 수정하지 않습니다. 수정사항이 문제를 해결하는 경우, QA에 `review-story` 재실행을 요청하여 게이트 업데이트

## 차단 조건

- `bmad-core/core-config.yaml` 누락
- `story_id`에 대한 스토리 파일을 찾을 수 없음
- QA 아티팩트를 찾을 수 없음(게이트나 평가 모두)
  - 중단하고 QA에 최소한 게이트 파일 생성 요청(또는 명확한 개발자 제공 수정 목록으로만 진행)

## 완료 체크리스트

- deno lint: 0 문제
- deno test -A: 모든 테스트 통과
- 모든 높은 심각도 `top_issues` 해결
- NFR FAIL → 해결됨; CONCERNS 최소화 또는 근거와 함께 문서화
- 커버리지 격차 해결 또는 근거와 함께 명시적 문서화
- 스토리 업데이트(허용된 섹션만) - 파일 목록 및 변경 로그 포함
- 상태 규칙에 따른 상태 설정

## 예시: 스토리 2.2

게이트 `docs/project/qa/gates/2.2-*.yml`에서 다음을 표시하는 경우

- `coverage_gaps`: 백 액션 동작 미테스트 (AC2)
- `coverage_gaps`: 중앙집중식 종속성 강제 미테스트 (AC4)

수정 계획:

- 툴킷 메뉴 "Back" 액션이 메인 메뉴로 돌아가는지 확인하는 테스트 추가
- 서비스/뷰의 임포트가 `deps.ts`를 통과하는지 확인하는 정적 테스트 추가
- lint/tests 재실행 및 Dev Agent Record + 파일 목록 적절히 업데이트

## 핵심 원칙

- 결정론적, 위험 우선 우선순위 지정
- 최소한의 유지 가능한 변경사항
- 테스트로 동작 검증 및 격차 해결
- 허용된 스토리 업데이트 영역에 대한 엄격한 준수
- 게이트 소유권은 QA에게; Dev는 상태를 통해 준비성 신호
