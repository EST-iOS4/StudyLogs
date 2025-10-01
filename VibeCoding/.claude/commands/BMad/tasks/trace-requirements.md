# /trace-requirements Task

When this command is used, execute the following task:

<!-- Powered by BMAD™ Core -->

# 요구사항 추적

포괄적인 추적성을 위해 Given-When-Then 패턴을 사용하여 스토리 요구사항을 테스트 케이스에 매핑합니다.

## 목적

모든 인수 기준이 해당 테스트 커버리지를 갖도록 하는 요구사항 추적성 매트릭스를 생성합니다. 이 태스크는 테스트의 격차를 식별하고 모든 요구사항이 검증되도록 도와줍니다.

**중요**: Given-When-Then은 여기서 요구사항과 테스트 간의 매핑을 문서화하는 데 사용되며, 실제 테스트 코드를 작성하는 데 사용되지 않습니다. 테스트는 프로젝트의 테스트 표준을 따라야 합니다(테스트 코드에서 BDD 구문 없음).

## 전제조건

- 명확한 인수 기준이 있는 스토리 파일
- 테스트 파일 또는 테스트 명세에 대한 접근
- 구현에 대한 이해

## 추적성 프로세스

### 1. 요구사항 추출

다음에서 모든 테스트 가능한 요구사항을 식별:

- 인수 기준 (주요 소스)
- 사용자 스토리 문장
- 특정 동작이 있는 태스크/하위태스크
- 언급된 비기능적 요구사항
- 문서화된 엣지 케이스

### 2. 테스트 케이스에 매핑

각 요구사항에 대해 어떤 테스트가 이를 검증하는지 문서화합니다. Given-When-Then을 사용하여 테스트가 검증하는 내용을 설명합니다(어떻게 작성되었는지가 아님):

```yaml
requirement: 'AC1: 사용자가 유효한 자격 증명으로 로그인할 수 있음'
test_mappings:
  - test_file: 'auth/login.test.ts'
    test_case: 'should successfully login with valid email and password'
    # Given-When-Then은 테스트가 검증하는 내용을 설명하며, 코딩 방법이 아님
    given: '유효한 자격 증명을 가진 등록된 사용자'
    when: '로그인 폼을 제출할 때'
    then: '대시보드로 리디렉션되고 세션이 생성됨'
    coverage: full

  - test_file: 'e2e/auth-flow.test.ts'
    test_case: 'complete login flow'
    given: '로그인 페이지의 사용자'
    when: '유효한 자격 증명을 입력하고 제출할 때'
    then: '사용자 데이터와 함께 대시보드가 로드됨'
    coverage: integration
```

### 3. 커버리지 분석

각 요구사항에 대한 커버리지 평가:

**커버리지 레벨:**

- `full`: 요구사항이 완전히 테스트됨
- `partial`: 일부 측면이 테스트됨, 격차 존재
- `none`: 테스트 커버리지를 찾을 수 없음
- `integration`: 통합/e2e 테스트에서만 커버됨
- `unit`: 단위 테스트에서만 커버됨

### 4. 격차 식별

발견된 격차를 문서화:

```yaml
coverage_gaps:
  - requirement: 'AC3: 비밀번호 재설정 이메일이 60초 내에 전송됨'
    gap: '이메일 전송 타이밍에 대한 테스트 없음'
    severity: medium
    suggested_test:
      type: integration
      description: '이메일 서비스 SLA 컴플라이언스 테스트'

  - requirement: 'AC5: 1000명의 동시 사용자 지원'
    gap: '로드 테스트가 구현되지 않음'
    severity: high
    suggested_test:
      type: performance
      description: '1000개의 동시 연결로 로드 테스트'
```

## 출력

### 출력 1: 게이트 YAML 블록

**`trace` 하위에 게이트 파일에 붙여넣기용으로 생성:**

```yaml
trace:
  totals:
    requirements: X
    full: Y
    partial: Z
    none: W
  planning_ref: 'qa.qaLocation/assessments/{epic}.{story}-test-design-{YYYYMMDD}.md'
  uncovered:
    - ac: 'AC3'
      reason: '비밀번호 재설정 타이밍에 대한 테스트를 찾을 수 없음'
  notes: 'qa.qaLocation/assessments/{epic}.{story}-trace-{YYYYMMDD}.md 참조'
```

### 출력 2: 추적성 보고서

**저장 위치:** `qa.qaLocation/assessments/{epic}.{story}-trace-{YYYYMMDD}.md`

다음을 포함한 추적성 보고서 생성:

```markdown
# 요구사항 추적성 매트릭스

## 스토리: {epic}.{story} - {title}

### 커버리지 요약

- 총 요구사항: X
- 완전 커버: Y (Z%)
- 부분 커버: A (B%)
- 커버되지 않음: C (D%)

### 요구사항 매핑

#### AC1: {승인 기준 1}

**커버리지: FULL**

Given-When-Then 매핑:

- **단위 테스트**: `auth.service.test.ts::validateCredentials`
  - Given: 유효한 사용자 자격 증명
  - When: 검증 메서드 호출됨
  - Then: 사용자 객체와 함께 true 반환

- **통합 테스트**: `auth.integration.test.ts::loginFlow`
  - Given: 유효한 계정을 가진 사용자
  - When: 로그인 API 호출됨
  - Then: JWT 토큰 반환되고 세션 생성됨

#### AC2: {승인 기준 2}

**커버리지: PARTIAL**

[모든 AC에 대해 계속...]

### 중요한 격차

1. **성능 요구사항**
   - 격차: 동시 사용자에 대한 로드 테스트 없음
   - 위험: 높음 - 프로덕션 로드 하에서 실패할 수 있음
   - 조치: k6 또는 유사한 도구를 사용하여 로드 테스트 구현

2. **보안 요구사항**
   - 격차: 속도 제한이 테스트되지 않음
   - 위험: 중간 - 잠재적 DoS 취약점
   - 조치: 통합 스위트에 속도 제한 테스트 추가

### 테스트 설계 권장사항

식별된 격차를 기반으로 권장:

1. 필요한 추가 테스트 시나리오
2. 구현할 테스트 유형 (단위/통합/e2e/성능)
3. 테스트 데이터 요구사항
4. Mock/stub 전략

### 위험 평가

- **높은 위험**: 커버리지가 없는 요구사항
- **중간 위험**: 부분 커버리지만 있는 요구사항
- **낮은 위험**: 완전한 단위 + 통합 커버리지가 있는 요구사항
```

## 추적성 모범 사례

### 매핑을 위한 Given-When-Then (테스트 코드가 아님)

각 테스트가 검증하는 내용을 문서화하기 위해 Given-When-Then 사용:

**Given**: 테스트가 설정하는 초기 컨텍스트

- 테스트가 준비하는 상태/데이터
- 시뮬레이션되는 사용자 컨텍스트
- 시스템 전제조건

**When**: 테스트가 수행하는 액션

- 테스트가 실행하는 내용
- 테스트되는 API 호출이나 사용자 액션
- 트리거되는 이벤트

**Then**: 테스트가 검증하는 내용

- 검증되는 예상 결과
- 확인되는 상태 변경
- 검증되는 값

**참고**: 이는 문서화 목적일 뿐입니다. 실제 테스트 코드는 프로젝트의 표준을 따릅니다(예: describe/it 블록, BDD 구문 없음).

### 커버리지 우선순위

다음을 기반으로 커버리지 우선순위 설정:

1. 중요한 비즈니스 플로우
2. 보안 관련 요구사항
3. 데이터 무결성 요구사항
4. 사용자 대면 기능
5. 성능 SLA

### 테스트 세분성

적절한 레벨에서 매핑:

- 비즈니스 로직용 단위 테스트
- 컴포넌트 상호작용용 통합 테스트
- 사용자 여정용 E2E 테스트
- NFR용 성능 테스트

## 품질 지표

좋은 추적성이 보여주는 것:

- 모든 AC에 최소한 하나의 테스트가 있음
- 중요한 경로에 여러 테스트 레벨이 있음
- 엣지 케이스가 명시적으로 커버됨
- NFR에 적절한 테스트 유형이 있음
- 각 테스트에 대한 명확한 Given-When-Then

## 주의 신호

다음을 주의:

- 테스트 커버리지가 없는 AC
- 요구사항에 매핑되지 않는 테스트
- 모호한 테스트 설명
- 누락된 엣지 케이스 커버리지
- 특정 테스트가 없는 NFR

## 게이트와의 통합

이 추적성은 품질 게이트에 반영됩니다:

- 중요한 격차 → FAIL
- 사소한 격차 → CONCERNS
- test-design에서 누락된 P0 테스트 → CONCERNS

### 출력 3: 스토리 훅 라인

**검토 태스크가 인용할 수 있도록 이 라인을 출력:**

```text
추적 매트릭스: qa.qaLocation/assessments/{epic}.{story}-trace-{YYYYMMDD}.md
```

- 완전한 커버리지 → PASS 기여

## 핵심 원칙

- 모든 요구사항은 테스트 가능해야 함
- 명확성을 위해 Given-When-Then 사용
- 존재와 부재 모두 식별
- 위험을 기반으로 우선순위 설정
- 권장사항을 실행 가능하게 만들기
