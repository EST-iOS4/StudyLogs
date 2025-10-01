<!-- Powered by BMAD™ Core -->

# 스토리 검토

품질 게이트 결정과 함께 포괄적인 테스트 아키텍처 검토를 수행합니다. 이 적응형, 위험 인식 검토는 스토리 업데이트와 상세한 게이트 파일을 모두 생성합니다.

## 입력값

```yaml
required:
  - story_id: '{epic}.{story}' # 예: "1.3"
  - story_path: '{devStoryLocation}/{epic}.{story}.*.md' # core-config.yaml의 경로
  - story_title: '{title}' # 누락 시 스토리 파일 H1에서 도출
  - story_slug: '{slug}' # 누락 시 제목에서 도출(소문자, 하이픈으로 연결)
```

## 전제조건

- 스토리 상태가 "Review"여야 함
- 개발자가 모든 태스크를 완료하고 파일 목록을 업데이트함
- 모든 자동화된 테스트가 통과함

## 검토 프로세스 - 적응형 테스트 아키텍처

### 1. 위험 평가 (검토 깊이 결정)

**다음의 경우 심층 검토로 자동 에스컬레이션:**

- 인증/결제/보안 파일이 수정됨
- 스토리에 추가된 테스트가 없음
- Diff > 500 lines
- 이전 게이트가 FAIL/CONCERNS였음
- 스토리에 5개 이상의 승인 기준이 있음

### 2. 포괄적 분석

#### A. 요구사항 추적성

- 각 승인 기준을 검증하는 테스트에 매핑 (테스트 코드가 아닌 Given-When-Then으로 매핑 문서화)
- 커버리지 차이 식별
- 모든 요구사항에 해당하는 테스트 케이스가 있는지 확인

#### B. 코드 품질 검토

- 아키텍처 및 디자인 패턴
- 리팩토링 기회 (그리고 수행)
- 코드 중복 또는 비효율성
- 성능 최적화
- 보안 취약점
- 모범 사례 준수

#### C. 테스트 아키텍처 평가

- 적절한 수준에서의 테스트 커버리지 적절성
- 테스트 수준 적절성 (단위 vs 통합 vs e2e 중 무엇이어야 하는지)
- 테스트 설계 품질 및 유지보수성
- 테스트 데이터 관리 전략
- 목/스텁 사용의 적절성
- 엣지 케이스 및 오류 시나리오 커버리지
- 테스트 실행 시간 및 신뢰성

#### D. 비기능적 요구사항 (NFR)

- 보안: 인증, 권한 부여, 데이터 보호
- 성능: 응답 시간, 자원 사용
- 신뢰성: 오류 처리, 복구 메커니즘
- 유지보수성: 코드 명확성, 문서화

#### E. 테스트 가능성 평가

- 제어성: 입력을 제어할 수 있는가?
- 관찰성: 출력을 관찰할 수 있는가?
- 디버깅 가능성: 실패를 쉽게 디버깅할 수 있는가?

#### F. 기술 부채 식별

- 누적된 우회책
- 누락된 테스트
- 오래된 종속성
- 아키텍처 위반

### 3. 능동적 리팩토링

- 안전하고 적절한 곳에서 코드 리팩토링
- 변경사항이 기능을 깨뜨리지 않는지 테스트 실행
- 명확한 이유와 방법과 함께 모든 변경사항을 QA 결과 섹션에 문서화
- QA 결과 섹션을 넘어서는 스토리 내용 변경 금지
- 스토리 상태나 파일 목록 변경 금지; 다음 상태만 권장

### 4. 표준 준수 확인

- `docs/coding-standards.md` 준수 확인
- `docs/unified-project-structure.md` 준수 확인
- `docs/testing-strategy.md`에 따른 테스트 접근법 검증
- 스토리에서 언급된 모든 가이드라인 준수 확인

### 5. 승인 기준 검증

- 각 AC가 완전히 구현되었는지 확인
- 누락된 기능 확인
- 엣지 케이스가 처리되는지 검증

### 6. 문서화 및 주석

- 가능한 경우 코드가 자체 문서화되는지 확인
- 누락된 경우 복잡한 로직에 주석 추가
- API 변경사항이 문서화되었는지 확인

## Output 1: Update Story File - QA Results Section ONLY

**CRITICAL**: You are ONLY authorized to update the "QA Results" section of the story file. DO NOT modify any other sections.

**QA Results Anchor Rule:**

- If `## QA Results` doesn't exist, append it at end of file
- If it exists, append a new dated entry below existing entries
- Never edit other sections

After review and any refactoring, append your results to the story file in the QA Results section:

```markdown
## 출력 1: 스토리 파일 업데이트 - QA 결과 섹션만

**중요**: QA 결과 섹션만 업데이트할 권한이 있습니다. 다른 섹션은 수정하지 마세요.

**QA 결과 앵커 규칙:**

- `## QA 결과`가 없으면 파일 끝에 추가
- 있으면 기존 항목 아래에 새로운 날짜 항목 추가
- 다른 섹션은 절대 편집 금지

검토 및 리팩토링 후, 스토리 파일의 QA 결과 섹션에 결과를 추가:

```markdown
## QA 결과

### 검토 날짜: [날짜]

### 검토자: Quinn (테스트 아키텍트)

### 코드 품질 평가

[구현 품질에 대한 전체적 평가]

### 수행된 리팩토링

[설명과 함께 수행한 리팩토링 목록]

- **파일**: [파일명]
  - **변경사항**: [변경된 내용]
  - **이유**: [변경 이유]
  - **방법**: [코드를 개선하는 방법]

### 준수 확인

- 코딩 표준: [✓/✗] [관련 메모]
- 프로젝트 구조: [✓/✗] [관련 메모]
- 테스트 전략: [✓/✗] [관련 메모]
- 모든 AC 충족: [✓/✗] [관련 메모]

### 개선사항 체크리스트

[직접 처리한 항목은 체크, 개발자가 처리해야 할 항목은 미체크로 남겨둠]

- [x] 더 나은 오류 처리를 위해 사용자 서비스 리팩토링 (services/user.service.ts)
- [x] 누락된 엣지 케이스 테스트 추가 (services/user.service.test.ts)
- [ ] 검증 로직을 별도 검증자 클래스로 추출 고려
- [ ] 오류 시나리오에 대한 통합 테스트 추가
- [ ] 새로운 오류 코드에 대한 API 문서 업데이트

### 보안 검토

[발견된 보안 문제와 처리 여부]

### 성능 고려사항

[발견된 성능 문제와 처리 여부]

### 검토 중 수정된 파일

[파일을 수정한 경우 여기에 나열 - 개발자에게 파일 목록 업데이트 요청]

### 게이트 상태

게이트: {STATUS} → qa.qaLocation/gates/{epic}.{story}-{slug}.yml
위험 프로필: qa.qaLocation/assessments/{epic}.{story}-risk-{YYYYMMDD}.md
NFR 평가: qa.qaLocation/assessments/{epic}.{story}-nfr-{YYYYMMDD}.md

# 참고: 경로는 사용자 정의 구성을 위해 core-config.yaml을 참조해야 함

### 권장 상태

[✓ Done 준비 완료] / [✗ 변경 필요 - 위의 미체크 항목 참조]
(스토리 소유자가 최종 상태 결정)
```

## 출력 2: 품질 게이트 파일 생성

**템플릿과 디렉토리:**

- `../templates/qa-gate-tmpl.yaml`에서 렌더링
- 누락된 경우 `qa.qaLocation/gates`에 정의된 디렉토리 생성 (`bmad-core/core-config.yaml` 참조)
- 저장 위치: `qa.qaLocation/gates/{epic}.{story}-{slug}.yml`

게이트 파일 구조:

```yaml
schema: 1
story: '{epic}.{story}'
story_title: '{스토리 제목}'
gate: PASS|CONCERNS|FAIL|WAIVED
status_reason: '게이트 결정에 대한 1-2문장 설명'
reviewer: 'Quinn (테스트 아키텍트)'
updated: '{ISO-8601 타임스탬프}'

top_issues: [] # 문제가 없으면 빈 배열
waiver: { active: false } # WAIVED인 경우에만 active: true로 설정

# 확장 필드 (선택사항이지만 권장):
quality_score: 0-100 # 100 - (20*FAILs) - (10*CONCERNS) 또는 technical-preferences.md 가중치 사용
expires: '{ISO-8601 타임스탬프}' # 일반적으로 검토일로부터 2주

evidence:
  tests_reviewed: { count }
  risks_identified: { count }
  trace:
    ac_covered: [1, 2, 3] # 테스트 커버리지가 있는 AC 번호
    ac_gaps: [4] # 커버리지가 부족한 AC 번호

nfr_validation:
  security:
    status: PASS|CONCERNS|FAIL
    notes: '구체적 발견사항'
  performance:
    status: PASS|CONCERNS|FAIL
    notes: '구체적 발견사항'
  reliability:
    status: PASS|CONCERNS|FAIL
    notes: '구체적 발견사항'
  maintainability:
    status: PASS|CONCERNS|FAIL
    notes: '구체적 발견사항'

recommendations:
  immediate: # 프로덕션 이전에 반드시 수정
    - action: '속도 제한 추가'
      refs: ['api/auth/login.ts']
  future: # 나중에 처리 가능
    - action: '캐싱 고려'
      refs: ['services/data.ts']
```
```

## Output 2: Create Quality Gate File

**Template and Directory:**

- Render from `../templates/qa-gate-tmpl.yaml`
- Create directory defined in `qa.qaLocation/gates` (see `bmad-core/core-config.yaml`) if missing
- Save to: `qa.qaLocation/gates/{epic}.{story}-{slug}.yml`

Gate file structure:

```yaml
schema: 1
story: '{epic}.{story}'
story_title: '{story title}'
gate: PASS|CONCERNS|FAIL|WAIVED
status_reason: '1-2 sentence explanation of gate decision'
reviewer: 'Quinn (Test Architect)'
updated: '{ISO-8601 timestamp}'

top_issues: [] # Empty if no issues
waiver: { active: false } # Set active: true only if WAIVED

# Extended fields (optional but recommended):
quality_score: 0-100 # 100 - (20*FAILs) - (10*CONCERNS) or use technical-preferences.md weights
expires: '{ISO-8601 timestamp}' # Typically 2 weeks from review

evidence:
  tests_reviewed: { count }
  risks_identified: { count }
  trace:
    ac_covered: [1, 2, 3] # AC numbers with test coverage
    ac_gaps: [4] # AC numbers lacking coverage

nfr_validation:
  security:
    status: PASS|CONCERNS|FAIL
    notes: 'Specific findings'
  performance:
    status: PASS|CONCERNS|FAIL
    notes: 'Specific findings'
  reliability:
    status: PASS|CONCERNS|FAIL
    notes: 'Specific findings'
  maintainability:
    status: PASS|CONCERNS|FAIL
    notes: 'Specific findings'

recommendations:
  immediate: # 프로덕션 이전에 반드시 수정
    - action: '속도 제한 추가'
      refs: ['api/auth/login.ts']
  future: # 나중에 처리 가능
    - action: '캐싱 고려'
      refs: ['services/data.ts']
```

### 게이트 결정 기준

**결정적 규칙 (순서대로 적용):**

risk_summary가 존재하는 경우, 먼저 그 임계값(≥9 → FAIL, ≥6 → CONCERNS)을 적용한 다음 NFR 상태, 그 다음 top_issues 심각도를 적용합니다.

1. **위험 임계값 (risk_summary가 있는 경우):**
   - 위험 점수 ≥ 9 → 게이트 = FAIL (면제되지 않은 경우)
   - 그렇지 않고 점수 ≥ 6 → 게이트 = CONCERNS

2. **테스트 커버리지 차이 (trace가 있는 경우):**
   - test-design의 P0 테스트가 누락된 경우 → 게이트 = CONCERNS
   - 보안/데이터 손실 P0 테스트가 누락된 경우 → 게이트 = FAIL

3. **문제 심각도:**
   - `top_issues.severity == high`인 경우 → 게이트 = FAIL (면제되지 않은 경우)
   - 그렇지 않고 `severity == medium`인 경우 → 게이트 = CONCERNS

4. **NFR 상태:**
   - NFR 상태가 FAIL인 경우 → 게이트 = FAIL
   - 그렇지 않고 NFR 상태가 CONCERNS인 경우 → 게이트 = CONCERNS
   - 그렇지 않으면 → 게이트 = PASS

- WAIVED는 waiver.active: true이고 이유/승인자가 있는 경우에만

상세 기준:

- **PASS**: 모든 중요 요구사항 충족, 차단 문제 없음
- **CONCERNS**: 중요하지 않은 문제 발견, 팀이 검토해야 함
- **FAIL**: 해결해야 할 중요한 문제
- **WAIVED**: 문제가 인정되었지만 팀에 의해 명시적으로 면제됨

### 품질 점수 계산

```text
quality_score = 100 - (20 × FAIL 수) - (10 × CONCERNS 수)
0과 100 사이로 제한
```

`technical-preferences.md`가 커스텀 가중치를 정의하는 경우, 대신 그것을 사용합니다.

### 제안된 소유자 관례

`top_issues`의 각 문제에 대해 `suggested_owner`를 포함:

- `dev`: 코드 변경 필요
- `sm`: 요구사항 명확화 필요
- `po`: 비즈니스 결정 필요

## 핵심 원칙

- 당신은 포괄적인 품질 평가를 제공하는 테스트 아키텍트입니다
- 적절한 경우 코드를 직접 개선할 권한이 있습니다
- 학습 목적으로 항상 변경사항을 설명하세요
- 완벽함과 실용주의 사이의 균형을 맞추세요
- 위험 기반 우선순위 지정에 집중하세요
- 명확한 소유권을 가진 실행 가능한 권장사항을 제공하세요

## 차단 조건

다음의 경우 검토를 중단하고 명확화를 요청:

- 스토리 파일이 불완전하거나 중요한 섹션이 누락됨
- 파일 목록이 비어있거나 명백히 불완전함
- 필요한 테스트가 없음
- 코드 변경사항이 스토리 요구사항과 일치하지 않음
- 논의가 필요한 중요한 아키텍처 문제

## 완료

검토 후:

1. 스토리 파일의 QA 결과 섹션 업데이트
2. `qa.qaLocation/gates` 디렉토리에 게이트 파일 생성
3. 상태 권장: "Done 준비 완료" 또는 "변경 필요" (소유자가 결정)
4. 파일이 수정된 경우, QA 결과에 나열하고 개발자에게 파일 목록 업데이트 요청
5. 항상 건설적인 피드백과 실행 가능한 권장사항 제공
