# /create-brownfield-story Task

When this command is used, execute the following task:

<!-- Powered by BMAD™ Core -->

# Create Brownfield Story Task

## Purpose

Create detailed, implementation-ready stories for brownfield projects where traditional sharded PRD/architecture documents may not exist. This task bridges the gap between various documentation formats (document-project output, brownfield PRDs, epics, or user documentation) and executable stories for the Dev agent.

## When to Use This Task

**Use this task when:**

- Working on brownfield projects with non-standard documentation
- Stories need to be created from document-project output
- Working from brownfield epics without full PRD/architecture
- Existing project documentation doesn't follow BMad v4+ structure
- Need to gather additional context from user during story creation

**Use create-next-story when:**

- Working with properly sharded PRD and v4 architecture documents
- Following standard greenfield or well-documented brownfield workflow
- All technical context is available in structured format

## Task Execution Instructions

### 0. Documentation Context

Check for available documentation in this order:

1. **Sharded PRD/Architecture** (docs/prd/, docs/architecture/)
   - If found, recommend using create-next-story task instead

2. **Brownfield Architecture Document** (docs/brownfield-architecture.md or similar)
   - Created by document-project task
   - Contains actual system state, technical debt, workarounds

3. **Brownfield PRD** (docs/prd.md)
   - May contain embedded technical details

4. **Epic Files** (docs/epics/ or similar)
   - Created by brownfield-create-epic task

5. **User-Provided Documentation**
   - Ask user to specify location and format

### 1. Story Identification and Context Gathering

#### 1.1 Identify Story Source

사용 가능한 문서를 기반으로:

- **브라운필드 PRD에서**: 에픽 섹션에서 스토리 추출
- **에픽 파일에서**: 에픽 정의 및 스토리 목록 읽기
- **사용자 지시에서**: 구현할 특정 개선사항을 사용자에게 문의
- **명확한 소스 없음**: 사용자와 함께 스토리 범위 정의

#### 1.2 필수 컨텍스트 수집

중요: 브라운필드 스토리의 경우, 안전한 구현을 위해 충분한 컨텍스트를 수집해야 합니다. 누락된 정보에 대해 사용자에게 문의할 준비를 하세요.

**필요한 정보 체크리스트:**

- [ ] 어떤 기존 기능이 영향을 받을 수 있는가?
- [ ] 현재 코드와의 통합 지점은 무엇인가?
- [ ] 따라야 할 패턴은 무엇인가 (예시와 함께)?
- [ ] 어떤 기술적 제약이 존재하는가?
- [ ] 알아야 할 "함정"이나 우회책이 있는가?

필요한 정보가 누락된 경우, 누락된 정보를 나열하고 사용자에게 제공을 요청하세요.

### 2. 사용 가능한 소스에서 기술적 컨텍스트 추출

#### 2.1 Document-Project 출력에서

document-project의 brownfield-architecture.md를 사용하는 경우:

- **기술 부채 섹션**: 이 스토리에 영향을 주는 우회책 확인
- **주요 파일 섹션**: 수정이 필요한 파일 식별
- **통합 지점**: 기존 통합 패턴 찾기
- **알려진 문제**: 스토리가 문제가 있는 영역을 건드리는지 확인
- **실제 기술 스택**: 버전 및 제약사항 확인

#### 2.2 브라운필드 PRD에서

브라운필드 PRD를 사용하는 경우:

- **기술적 제약사항 섹션**: 모든 관련 제약사항 추출
- **통합 요구사항**: 호환성 요구사항 확인
- **코드 구성**: 지정된 패턴 준수
- **위험 평가**: 잠재적 영향 이해

#### 2.3 사용자 문서에서

사용자에게 다음을 식별하도록 도움 요청:

- 관련 기술 명세
- 따라야 할 기존 코드 예시
- 통합 요구사항
- 프로젝트에서 사용되는 테스트 접근법

### 3. 점진적 세부사항 수집을 통한 스토리 생성

#### 3.1 초기 스토리 구조 생성

알려진 내용으로 스토리 템플릿을 채우면서 시작:

```markdown
# 스토리 {{개선사항 제목}}

## 상태: Draft

## 스토리

{{사용자_유형}}로서,
{{개선사항_기능}}을 원하며,
{{전달되는_가치}}를 얻고자 합니다.

## 컨텍스트 소스

- 소스 문서: {{문서 이름/유형}}
- 개선사항 유형: {{단일 기능/버그 수정/통합/기타}}
- 기존 시스템 영향: {{간단한 평가}}
```

#### 3.2 인수 기준 개발

중요: 브라운필드의 경우, 기존 기능 유지에 대한 기준을 항상 포함하세요

표준 구조:

1. 새로운 기능이 지정된 대로 작동
2. 기존 {{영향받는 기능}}이 변경 없이 계속 작동
3. {{기존 시스템}}과의 통합이 현재 동작 유지
4. {{관련 영역}}에서 회귀 없음
5. 성능이 허용 가능한 범위 내에서 유지

#### 3.3 기술적 안내 수집

중요: 정보가 누락된 경우 사용자와 상호작용해야 하는 부분입니다

사용 가능한 정보로 Dev Technical Guidance 섹션 생성:

````markdown
## Dev 기술적 안내

### 기존 시스템 컨텍스트

[사용 가능한 문서에서 추출]

### 통합 접근법

[발견된 패턴을 기반으로 하거나 사용자에게 문의]

### 기술적 제약사항

[문서 또는 사용자 입력에서]

### 누락된 정보

중요: dev가 필요로 하지만 찾을 수 없었던 것들을 나열하고 누락된 정보를 요청

### 4. 안전 확인과 함께하는 태스크 생성

#### 4.1 구현 태스크 생성

수집된 컨텍스트를 기반으로 다음과 같은 태스크 생성:

- 시스템 이해가 불완전한 경우 탐색 태스크 포함
- 기존 기능에 대한 검증 태스크 추가
- 롤백 고려사항 포함
- 알려진 경우 특정 파일/패턴 참조

브라운필드를 위한 태스크 구조 예시:

```markdown
## 태스크 / 하위태스크

- [ ] 태스크 1: 기존 {{컴포넌트/기능}} 구현 분석
  - [ ] 현재 패턴을 위해 {{특정 파일}} 검토
  - [ ] 통합 지점 문서화
  - [ ] 잠재적 영향 식별

- [ ] 태스크 2: {{새 기능}} 구현
  - [ ] {{예시 파일}}의 패턴 준수
  - [ ] {{기존 컴포넌트}}와 통합
  - [ ] {{제약사항}}과의 호환성 유지

- [ ] 태스크 3: 기존 기능 검증
  - [ ] {{기존 기능 1}}이 여전히 작동하는지 테스트
  - [ ] {{통합 지점}} 동작이 변경되지 않았는지 확인
  - [ ] 성능 영향 확인

- [ ] 태스크 4: 테스트 추가
  - [ ] {{프로젝트 테스트 패턴}}을 따르는 단위 테스트
  - [ ] {{통합 지점}}에 대한 통합 테스트
  - [ ] 필요한 경우 기존 테스트 업데이트
```
````

### 5. 위험 평가 및 완화

중요: 브라운필드의 경우 - 항상 위험 평가 포함

브라운필드별 위험을 위한 섹션 추가:

```markdown
## 위험 평가

### 구현 위험

- **주요 위험**: {{기존 시스템에 대한 주요 위험}}
- **완화방안**: {{해결 방법}}
- **검증**: {{안전성 확인 방법}}

### 롤백 계획

- {{필요한 경우 변경사항을 취소하는 간단한 단계}}

### 안전 확인

- [ ] 변경 전 기존 {{기능}} 테스트
- [ ] 변경사항을 기능 플래그하거나 격리 가능
- [ ] 롤백 절차 문서화
```

### 6. 최종 스토리 검증

확정 전:

1. **완전성 확인**:
   - [ ] 스토리에 명확한 범위와 인수 기준이 있음
   - [ ] 구현을 위한 기술적 컨텍스트가 충분함
   - [ ] 통합 접근법이 정의됨
   - [ ] 완화방안과 함께 위험이 식별됨

2. **안전 확인**:
   - [ ] 기존 기능 보호가 포함됨
   - [ ] 롤백 계획이 실행 가능함
   - [ ] 테스트가 새 기능과 기존 기능을 모두 커버함

3. **정보 격차**:
   - [ ] 모든 중요한 누락 정보를 사용자로부터 수집
   - [ ] 남은 미지사항을 dev 에이전트를 위해 문서화
   - [ ] 필요한 곳에 탐색 태스크 추가

### 7. 스토리 출력 형식

적절한 이름으로 스토리 저장:

- 에픽에서 나온 경우: `docs/stories/epic-{n}-story-{m}.md`
- 독립적인 경우: `docs/stories/brownfield-{기능-이름}.md`
- 순차적인 경우: 기존 스토리 번호 매기기 준수

문서 컨텍스트를 언급하는 헤더 포함:

```markdown
# 스토리: {{제목}}

<!-- 소스: {{사용된 문서 유형}} -->
<!-- 컨텍스트: {{기존 시스템}}에 대한 브라운필드 개선사항 -->

## 상태: Draft

[나머지 스토리 콘텐츠...]
```

### 8. 인계 커뮤니케이션

사용자에게 명확한 인계 제공:

```text
브라운필드 스토리 생성됨: {{스토리 제목}}

소스 문서: {{사용된 것}}
스토리 위치: {{파일 경로}}

식별된 주요 통합 지점:
- {{통합 지점 1}}
- {{통합 지점 2}}

확인된 위험:
- {{주요 위험}}

{{누락된 정보가 있는 경우}}:
참고: 일부 기술적 세부사항이 불분명했습니다. 스토리에는 구현 중 필요한 정보를 수집하기 위한 탐색 태스크가 포함되어 있습니다.

다음 단계:
1. 정확성을 위한 스토리 검토
2. 통합 접근법이 시스템과 일치하는지 확인
3. 스토리 승인 또는 조정 요청
4. Dev 에이전트가 안전 확인과 함께 구현 가능
```

## 성공 기준

다음의 경우 브라운필드 스토리 생성이 성공적:

1. 스토리가 dev가 여러 문서를 검색할 필요 없이 구현 가능
2. 통합 접근법이 명확하고 기존 시스템에 안전함
3. 모든 사용 가능한 기술적 컨텍스트가 추출되고 구성됨
4. 누락된 정보가 식별되고 해결됨
5. 위험이 완화 전략과 함께 문서화됨
6. 스토리에 기존 기능 검증이 포함됨
7. 롤백 접근법이 정의됨

## 중요 참고사항

- 이 태스크는 특별히 비표준 문서를 가진 브라운필드 프로젝트를 위한 것
- 새로운 기능보다 기존 시스템 안정성을 항상 우선시
- 의심스러울 때는 탐색 및 검증 태스크 추가
- 가정하기보다는 사용자에게 명확화를 요청하는 것이 좋음
- 각 스토리는 dev 에이전트를 위해 독립적이어야 함
- 사용 가능한 경우 기존 코드 패턴에 대한 참조 포함
