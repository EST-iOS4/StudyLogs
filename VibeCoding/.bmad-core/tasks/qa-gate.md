<!-- Powered by BMAD™ Core -->

# QA 게이트

검토 결과를 기반으로 스토리에 대한 품질 게이트 결정 파일을 생성하거나 업데이트합니다.

## 목적

실행 가능한 피드백과 함께 명확한 통과/실패 결정을 제공하는 독립적인 품질 게이트 파일을 생성합니다. 이 게이트는 팀이 품질 상태를 이해할 수 있는 자문 체크포인트 역할을 합니다.

## 전제조건

- 스토리가 검토됨 (수동 또는 review-story 태스크를 통해)
- 검토 결과가 이용 가능
- 스토리 요구사항 및 구현에 대한 이해

## 게이트 파일 위치

**항상** `qa.qaLocation/gates`에 대한 `bmad-core/core-config.yaml`을 확인

슬러그 규칙:

- 소문자로 변환
- 공백을 하이픈으로 교체
- 구두점 제거
- 예시: "User Auth - Login!"은 "user-auth-login"이 됨

## 최소 필수 스키마

```yaml
schema: 1
story: '{epic}.{story}'
gate: PASS|CONCERNS|FAIL|WAIVED
status_reason: '게이트 결정에 대한 1-2문장 설명'
reviewer: 'Quinn'
updated: '{ISO-8601 타임스탬프}'
top_issues: [] # 문제가 없으면 빈 배열
waiver: { active: false } # WAIVED인 경우에만 active: true로 설정
```

## 문제가 있는 스키마

```yaml
schema: 1
story: '1.3'
gate: CONCERNS
status_reason: '인증 엔드포인트의 속도 제한 누락으로 보안 위험 발생.'
reviewer: 'Quinn'
updated: '2025-01-12T10:15:00Z'
top_issues:
  - id: 'SEC-001'
    severity: high # 고정값: low|medium|high만 사용
    finding: '로그인 엔드포인트에 속도 제한 없음'
    suggested_action: '프로덕션 이전에 속도 제한 미들웨어 추가'
  - id: 'TEST-001'
    severity: medium
    finding: '인증 플로우에 대한 통합 테스트 없음'
    suggested_action: '통합 테스트 커버리지 추가'
waiver: { active: false }
```

## 면제된 경우의 스키마

```yaml
schema: 1
story: '1.3'
gate: WAIVED
status_reason: 'MVP 릴리스를 위해 알려진 문제 수용.'
reviewer: 'Quinn'
updated: '2025-01-12T10:15:00Z'
top_issues:
  - id: 'PERF-001'
    severity: low
    finding: '1000+ 항목이 있을 때 대시보드가 느리게 로드됨'
    suggested_action: '다음 스프린트에서 페이지네이션 구현'
waiver:
  active: true
  reason: 'MVP 릴리스 - 성능 최적화 연기'
  approved_by: '제품 책임자'
```

## 게이트 결정 기준

### PASS

- 모든 승인 기준 충족
- 높은 심각도 문제 없음
- 테스트 커버리지가 프로젝트 기준 충족

### CONCERNS

- 차단되지 않는 문제 존재
- 추적하고 일정을 잡아야 함
- 인지한 상태로 진행 가능

### FAIL

- 승인 기준 미충족
- 높은 심각도 문제 존재
- InProgress로 되돌리기 권장

### WAIVED

- 문제를 명시적으로 수용
- 승인과 이유 필요
- 알려진 문제에도 불구하고 진행

## 심각도 척도

**고정값 - 변형 불가:**

- `low`: 사소한 문제, 외관상 문제
- `medium`: 곧 수정해야 함, 차단되지 않음
- `high`: 중요한 문제, 릴리스를 차단해야 함

## 문제 ID 접두사

- `SEC-`: 보안 문제
- `PERF-`: 성능 문제
- `REL-`: 신뢰성 문제
- `TEST-`: 테스트 공백
- `MNT-`: 유지보수성 우려
- `ARCH-`: 아키텍처 문제
- `DOC-`: 문서 공백
- `REQ-`: 요구사항 문제

## 출력 요구사항

1. **항상** `bmad-core/core-config.yaml`의 `qa.qaLocation/gates`에 게이트 파일 생성
2. **항상** 스토리의 QA 결과 섹션에 이 정확한 형식 추가:

   ```text
   게이트: {STATUS} → qa.qaLocation/gates/{epic}.{story}-{slug}.yml
   ```

3. status_reason을 최대 1-2문장으로 유지
4. 심각도 값을 정확히 사용: `low`, `medium`, 또는 `high`

## 스토리 업데이트 예시

게이트 파일 생성 후, 스토리의 QA 결과 섹션에 추가:

```markdown
## QA 결과

### 검토 날짜: 2025-01-12

### 검토자: Quinn (테스트 아키텍트)

[... 기존 검토 내용 ...]

### 게이트 상태

게이트: CONCERNS → qa.qaLocation/gates/{epic}.{story}-{slug}.yml
```

## 핵심 원칙

- 최소화되고 예측 가능하게 유지
- 고정된 심각도 척도 (low/medium/high)
- 항상 표준 경로에 작성
- 항상 게이트 참조로 스토리 업데이트
- 명확하고 실행 가능한 발견사항
