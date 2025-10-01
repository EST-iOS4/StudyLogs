# /test-design Task

When this command is used, execute the following task:

<!-- Powered by BMAD™ Core -->

# 테스트 설계

스토리 구현을 위한 적절한 테스트 레벨 권장사항과 함께 포괄적인 테스트 시나리오를 생성합니다.

## 입력값

```yaml
required:
  - story_id: '{epic}.{story}' # 예: "1.3"
  - story_path: '{devStoryLocation}/{epic}.{story}.*.md' # core-config.yaml의 경로
  - story_title: '{title}' # 누락 시 스토리 파일 H1에서 도출
  - story_slug: '{slug}' # 누락 시 제목에서 도출(소문자, 하이픈으로 연결)
```

## 목적

무엇을 테스트할지, 어떤 레벨에서(단위/통합/e2e), 그리고 왜 그런지를 식별하는 완전한 테스트 전략을 설계합니다. 이는 적절한 테스트 경계를 유지하면서 중복 없이 효율적인 테스트 커버리지를 보장합니다.

## 종속성

```yaml
data:
  - test-levels-framework.md # 단위/통합/E2E 결정 기준
  - test-priorities-matrix.md # P0/P1/P2/P3 분류 시스템
```

## 프로세스

### 1. 스토리 요구사항 분석

각 승인 기준을 테스트 가능한 시나리오로 세분화합니다. 각 AC에 대해:

- 테스트할 핵심 기능 식별
- 필요한 데이터 변형 결정
- 오류 조건 고려
- 엣지 케이스 기록

### 2. 테스트 레벨 프레임워크 적용

**참조:** 상세 기준은 `test-levels-framework.md` 로드

빠른 규칙:

- **단위**: 순수 로직, 알고리즘, 계산
- **통합**: 컴포넌트 상호작용, DB 작업
- **E2E**: 중요한 사용자 여정, 컴플라이언스

### 3. 우선순위 할당

**참조:** 분류를 위해 `test-priorities-matrix.md` 로드

빠른 우선순위 할당:

- **P0**: 수익 중요, 보안, 컴플라이언스
- **P1**: 핵심 사용자 여정, 자주 사용
- **P2**: 보조 기능, 관리 기능
- **P3**: 있으면 좋은, 거의 사용되지 않음

### 4. 테스트 시나리오 설계

식별된 각 테스트 요구사항에 대해 생성:

```yaml
test_scenario:
  id: '{epic}.{story}-{LEVEL}-{SEQ}'
  requirement: 'AC 참조'
  priority: P0|P1|P2|P3
  level: unit|integration|e2e
  description: '테스트되는 내용'
  justification: '이 레벨을 선택한 이유'
  mitigates_risks: ['RISK-001'] # 위험 프로필이 있는 경우
```

### 5. 커버리지 검증

다음을 보장:

- 모든 AC에 최소 하나의 테스트
- 레벨 간 중복 커버리지 없음
- 중요 경로에 여러 레벨
- 위험 완화가 다뤄짐

## 출력

### 출력 1: 테스트 설계 문서

**저장 위치:** `qa.qaLocation/assessments/{epic}.{story}-test-design-{YYYYMMDD}.md`

```markdown
# 테스트 설계: 스토리 {epic}.{story}

날짜: {date}
설계자: Quinn (테스트 아키텍트)

## 테스트 전략 개요

- 총 테스트 시나리오: X
- 단위 테스트: Y (A%)
- 통합 테스트: Z (B%)
- E2E 테스트: W (C%)
- 우선순위 분포: P0: X, P1: Y, P2: Z

## 승인 기준별 테스트 시나리오

### AC1: {설명}

#### 시나리오

| ID           | 레벨        | 우선순위 | 테스트                    | 근거                     |
| ------------ | ----------- | -------- | ------------------------- | ------------------------ |
| 1.3-UNIT-001 | 단위        | P0       | 입력 형식 검증            | 순수 검증 로직           |
| 1.3-INT-001  | 통합        | P0       | 서비스가 요청 처리        | 다중 컴포넌트 플로우     |
| 1.3-E2E-001  | E2E         | P1       | 사용자가 여정 완료        | 중요 경로 검증           |

[모든 AC에 대해 계속...]

## 위험 커버리지

[위험 프로필이 있는 경우 테스트 시나리오를 식별된 위험에 매핑]

## 권장 실행 순서

1. P0 단위 테스트 (빠른 실패)
2. P0 통합 테스트
3. P0 E2E 테스트
4. P1 테스트 순서대로
5. 시간이 허락하는 대로 P2+
```

### 출력 2: 게이트 YAML 블록

품질 게이트에 포함하기 위해 생성:

```yaml
test_design:
  scenarios_total: X
  by_level:
    unit: Y
    integration: Z
    e2e: W
  by_priority:
    p0: A
    p1: B
    p2: C
  coverage_gaps: [] # 테스트가 없는 AC 목록
```

### 출력 3: 추적 참조

trace-requirements 태스크에서 사용하기 위해 출력:

```text
테스트 설계 매트릭스: qa.qaLocation/assessments/{epic}.{story}-test-design-{YYYYMMDD}.md
P0 테스트 식별: {count}
```

## 품질 체크리스트

확정하기 전에 확인:

- [ ] 모든 AC에 테스트 커버리지가 있음
- [ ] 테스트 레벨이 적절함 (과도한 테스트 아님)
- [ ] 레벨 간 중복 커버리지 없음
- [ ] 우선순위가 비즈니스 위험과 일치
- [ ] 테스트 ID가 명명 규칙을 따름
- [ ] 시나리오가 원자적이고 독립적임

## 핵심 원칙

- **좌측 이동**: 통합보다 단위, E2E보다 통합 선호
- **위험 기반**: 잘못될 수 있는 것에 집중
- **효율적 커버리지**: 적절한 레벨에서 한 번 테스트
- **유지보수성**: 장기 테스트 유지보수 고려
- **빠른 피드백**: 빠른 테스트 먼저 실행
