<!-- Powered by BMAD™ Core -->

# NFR 평가

핵심 4가지에 집중한 빠른 NFR 검증: 보안, 성능, 신뢰성, 유지보수성.

## 입력값

```yaml
required:
  - story_id: '{epic}.{story}' # 예: "1.3"
  - story_path: `devStoryLocation`을 위한 `bmad-core/core-config.yaml`

optional:
  - architecture_refs: `architecture.architectureFile`을 위한 `bmad-core/core-config.yaml`
  - technical_preferences: `technicalPreferences`를 위한 `bmad-core/core-config.yaml`
  - acceptance_criteria: 스토리 파일에서
```

## 목적

스토리에 대한 비기능적 요구사항을 평가하고 다음을 생성:

1. 게이트 파일의 `nfr_validation` 섹션용 YAML 블록
2. `qa.qaLocation/assessments/{epic}.{story}-nfr-{YYYYMMDD}.md`에 저장되는 간단한 마크다운 평가

## 프로세스

### 0. 누락된 입력에 대한 안전장치

story_path나 스토리 파일을 찾을 수 없는 경우:

- "소스 스토리를 찾을 수 없음" 메모와 함께 평가 파일을 여전히 생성
- 선택된 모든 NFR을 "대상 알 수 없음 / 증거 누락" 메모와 함께 CONCERNS로 설정
- 가치를 제공하기 위해 평가를 계속 진행

### 1. 범위 도출

**상호작용 모드:** 평가할 NFR을 묻기
**비상호작용 모드:** 핵심 4가지로 기본 설정 (보안, 성능, 신뢰성, 유지보수성)

```text
어떤 NFR을 평가해야 할까요? (숫자를 입력하거나 기본값을 위해 엔터를 누르세요)
[1] 보안 (기본값)
[2] 성능 (기본값)
[3] 신뢰성 (기본값)
[4] 유지보수성 (기본값)
[5] 사용성
[6] 호환성
[7] 이식성
[8] Functional Suitability

> [Enter for 1-4]
```

### 2. 임계값 확인

다음에서 NFR 요구사항 찾기:

- 스토리 승인 기준
- `docs/architecture/*.md` 파일
- `docs/technical-preferences.md`

**상호작용 모드:** 누락된 임계값 질문
**비상호작용 모드:** "대상 알 수 없음"으로 CONCERNS 표시

```text
성능 요구사항을 찾을 수 없습니다. 목표 응답 시간은 무엇입니까?
> API 호출의 경우 200ms

보안 요구사항을 찾을 수 없습니다. 필요한 인증 방법은?
> 리프레시 토큰이 있는 JWT
```

**알 수 없는 대상 정책:** 대상이 누락되고 제공되지 않는 경우, "대상 알 수 없음" 메모와 함께 상태를 CONCERNS로 표시

### 3. 빠른 평가

선택된 각 NFR에 대해 확인:

- 구현되었다는 증거가 있는가?
- 검증할 수 있는가?
- 명백한 차이가 있는가?

### 4. 출력 생성

## 출력 1: 게이트 YAML 블록

실제로 평가된 NFR만 생성 (플레이스홀더 없음):

```yaml
# 게이트 YAML (복사/붙여넣기):
nfr_validation:
  _assessed: [security, performance, reliability, maintainability]
  security:
    status: CONCERNS
    notes: '인증 엔드포인트에 속도 제한 없음'
  performance:
    status: PASS
    notes: '응답 시간 < 200ms 확인됨'
  reliability:
    status: PASS
    notes: '오류 처리 및 재시도 구현됨'
  maintainability:
    status: CONCERNS
    notes: '테스트 커버리지 65%, 목표는 80%'
```

## 결정적 상태 규칙

- **FAIL**: 선택된 NFR에 중요한 차이가 있거나 대상이 명백히 충족되지 않음
- **CONCERNS**: FAIL은 없지만 NFR이 알 수 없음/부분적/증거 누락
- **PASS**: 선택된 모든 NFR이 증거와 함께 대상을 충족

## 품질 점수 계산

```
quality_score = 100
- 각 FAIL 속성당 20점 감소
- 각 CONCERNS 속성당 10점 감소
최소 0, 최대 100
```

`technical-preferences.md`가 커스텀 가중치를 정의하는 경우, 대신 그것을 사용합니다.

## 출력 2: 간단한 평가 보고서

**항상 저장:** `qa.qaLocation/assessments/{epic}.{story}-nfr-{YYYYMMDD}.md`

```markdown
# NFR 평가: {epic}.{story}

날짜: {date}
검토자: Quinn

<!-- 참고: 소스 스토리를 찾을 수 없음 (해당하는 경우) -->

## 요약

- 보안: CONCERNS - 속도 제한 누락
- 성능: PASS - <200ms 요구사항 충족
- 신뢰성: PASS - 적절한 오류 처리
- 유지보수성: CONCERNS - 테스트 커버리지가 목표 미달

## 중요한 문제

1. **속도 제한 없음** (보안)
   - 위험: 무차별 대입 공격 가능
   - 수정: 인증 엔드포인트에 속도 제한 미들웨어 추가

2. **테스트 커버리지 65%** (유지보수성)
   - 위험: 테스트되지 않은 코드 경로
   - 수정: 커버되지 않은 분기에 테스트 추가

## 빠른 개선

- 속도 제한 추가: ~2시간
- 테스트 커버리지 증가: ~4시간
- 성능 모니터링 추가: ~1시간
```

## 출력 3: 스토리 업데이트 라인

**검토 태스크가 인용할 수 있도록 이 라인으로 끝내기:**

```
NFR 평가: qa.qaLocation/assessments/{epic}.{story}-nfr-{YYYYMMDD}.md
```

## 출력 4: 게이트 통합 라인

**끝에 항상 출력:**

```
게이트 NFR 블록 준비 완료 → qa.qaLocation/gates/{epic}.{story}-{slug}.yml의 nfr_validation 아래에 붙여넣기
```

## 평가 기준

### 보안

**PASS 조건:**

- 인증 구현됨
- 권한 부여 강제됨
- 입력 검증 존재
- 하드코딩된 비밀 없음

**CONCERNS 조건:**

- 속도 제한 누락
- 약한 암호화
- 불완전한 권한 부여

**FAIL 조건:**

- 인증 없음
- 하드코딩된 자격 증명
- SQL 인젝션 취약점

### 성능

**PASS 조건:**

- 응답 시간 목표 충족
- 명백한 병목 현상 없음
- 합리적인 자원 사용

**CONCERNS 조건:**

- 한계에 근접
- 인덱스 누락
- 캐싱 전략 없음

**FAIL 조건:**

- 응답 시간 한계 초과
- 메모리 누수
- 최적화되지 않은 쿼리

### 신뢰성

**PASS 조건:**

- 오류 처리 존재
- 우아한 성능 저하
- 필요한 곳에 재시도 로직

**CONCERNS 조건:**

- 일부 오류 케이스 처리되지 않음
- 서킷 브레이커 없음
- 상태 확인 누락

**FAIL 조건:**

- 오류 처리 없음
- 오류 시 크래시
- 복구 메커니즘 없음

### 유지보수성

**PASS 조건:**

- 테스트 커버리지가 목표 충족
- 코드 잘 구조화됨
- 문서 존재

**CONCERNS 조건:**

- 테스트 커버리지가 목표 미달
- 일부 코드 중복
- 문서 누락

**FAIL 조건:**

- 테스트 없음
- 높은 결합도 코드
- 문서 없음

## 빠른 참조

### 확인할 항목

```yaml
security:
  - 인증 메커니즘
  - 권한 부여 확인
  - 입력 검증
  - 비밀 관리
  - 속도 제한

performance:
  - 응답 시간
  - 데이터베이스 쿼리
  - 캐싱 사용
  - 자원 소비

reliability:
  - 오류 처리
  - 재시도 로직
  - 서킷 브레이커
  - 상태 확인
  - 로깅

maintainability:
  - 테스트 커버리지
  - 코드 구조
  - 문서
  - 종속성
```

## 핵심 원칙

- 기본적으로 핵심 4개 NFR에 집중
- 심층 분석이 아닌 빠른 평가
- 게이트 준비 출력 형식
- 간단하고 실행 가능한 발견사항
- 적용되지 않는 것은 건너뛰기
- 일관성을 위한 결정적 상태 규칙
- 알 수 없는 대상 → 추측이 아닌 CONCERNS

---

## 부록: ISO 25010 참조

<details>
<summary>전체 ISO 25010 품질 모델 (클릭하여 확장)</summary>

### 8가지 품질 특성

1. **기능적 적합성**: 완전성, 정확성, 적절성
2. **성능 효율성**: 시간 동작, 자원 사용, 용량
3. **호환성**: 공존, 상호 운용성
4. **사용성**: 학습 가능성, 조작 가능성, 접근성
5. **신뢰성**: 성숙도, 가용성, 내결함성
6. **보안**: 기밀성, 무결성, 진정성
7. **유지보수성**: 모듈성, 재사용성, 테스트 가능성
8. **이식성**: 적응성, 설치 가능성

핵심 4개 이외의 평가 시 이를 사용하세요.

</details>

<details>
<summary>예시: 심층 성능 분석 (클릭하여 확장)</summary>

```yaml
performance_deep_dive:
  response_times:
    p50: 45ms
    p95: 180ms
    p99: 350ms
  database:
    slow_queries: 2
    missing_indexes: ['users.email', 'orders.user_id']
  caching:
    hit_rate: 0%
    recommendation: '세션 데이터를 위한 Redis 추가'
  load_test:
    max_rps: 150
    breaking_point: 200 rps
```

</details>
