<!-- Powered by BMAD™ Core -->

# 제품 오너 (PO) 마스터 검증 체크리스트

이 체크리스트는 제품 오너가 개발 실행 전에 프로젝트 계획을 검증하는 포괄적인 프레임워크 역할을 합니다. 프로젝트 유형(그린필드 vs 브라운필드)에 따라 지능적으로 적응하며 해당하는 경우 UI/UX 고려사항을 포함합니다.

[[LLM: 초기화 지시사항 - PO 마스터 체크리스트

프로젝트 유형 감지:
먼저 다음을 확인하여 프로젝트 유형을 결정하세요:

1. 이것이 그린필드 프로젝트(처음부터 새로 시작)인가요?
   - 찾을 것: 새 프로젝트 초기화, 기존 코드베이스 참조 없음
   - 확인할 것: prd.md, architecture.md, 새 프로젝트 설정 스토리

2. 이것이 브라운필드 프로젝트(기존 시스템 개선)인가요?
   - 찾을 것: 기존 코드베이스 참조, 개선/수정 언어
   - 확인할 것: brownfield-prd.md, brownfield-architecture.md, 기존 시스템 분석

3. 프로젝트에 UI/UX 구성 요소가 포함되어 있나요?
   - 확인할 것: frontend-architecture.md, UI/UX 사양, 디자인 파일
   - 찾을 것: 프론트엔드 스토리, 컴포넌트 사양, 사용자 인터페이스 언급

문서 요구사항:
프로젝트 유형에 따라 다음에 대한 접근 권한이 있는지 확인하세요:

그린필드 프로젝트의 경우:

- prd.md - 제품 요구사항 문서
- architecture.md - 시스템 아키텍처
- frontend-architecture.md - UI/UX가 관련된 경우
- 모든 에픽 및 스토리 정의

브라운필드 프로젝트의 경우:

- brownfield-prd.md - 브라운필드 개선 요구사항
- brownfield-architecture.md - 개선 아키텍처
- 기존 프로젝트 코드베이스 접근 (중요 - 이것 없이는 진행 불가)
- 현재 배포 구성 및 인프라 세부사항
- 데이터베이스 스키마, API 문서, 모니터링 설정

건너뛰기 지시사항:

- 그린필드 프로젝트의 경우 [[BROWNFIELD ONLY]]로 표시된 섹션 건너뛰기
- 브라운필드 프로젝트의 경우 [[GREENFIELD ONLY]]로 표시된 섹션 건너뛰기
- 백엔드 전용 프로젝트의 경우 [[UI/UX ONLY]]로 표시된 섹션 건너뛰기
- 최종 보고서에서 건너뛴 모든 섹션 기록

검증 접근 방식:

1. Deep Analysis - Thoroughly analyze each item against documentation
2. Evidence-Based - Cite specific sections or code when validating
3. Critical Thinking - Question assumptions and identify gaps
4. Risk Assessment - Consider what could go wrong with each decision

EXECUTION MODE:
Ask the user if they want to work through the checklist:

- Section by section (interactive mode) - Review each section, get confirmation before proceeding
- All at once (comprehensive mode) - Complete full analysis and present report at end]]

## 1. PROJECT SETUP & INITIALIZATION

[[LLM: Project setup is the foundation. For greenfield, ensure clean start. For brownfield, ensure safe integration with existing system. Verify setup matches project type.]]

### 1.1 Project Scaffolding [[GREENFIELD ONLY]]

- [ ] Epic 1 includes explicit steps for project creation/initialization
- [ ] If using a starter template, steps for cloning/setup are included
- [ ] If building from scratch, all necessary scaffolding steps are defined
- [ ] Initial README or documentation setup is included
- [ ] Repository setup and initial commit processes are defined

### 1.2 Existing System Integration [[BROWNFIELD ONLY]]

- [ ] Existing project analysis has been completed and documented
- [ ] Integration points with current system are identified
- [ ] Development environment preserves existing functionality
- [ ] Local testing approach validated for existing features
- [ ] Rollback procedures defined for each integration point

### 1.3 Development Environment

- [ ] Local development environment setup is clearly defined
- [ ] Required tools and versions are specified
- [ ] Steps for installing dependencies are included
- [ ] Configuration files are addressed appropriately
- [ ] Development server setup is included

### 1.4 Core Dependencies

- [ ] All critical packages/libraries are installed early
- [ ] Package management is properly addressed
- [ ] Version specifications are appropriately defined
- [ ] Dependency conflicts or special requirements are noted
- [ ] [[BROWNFIELD ONLY]] Version compatibility with existing stack verified

## 2. 인프라 & 배포

[[LLM: 인프라는 사용 전에 존재해야 합니다. 브라운필드의 경우, 기존 시스템을 손상시키지 않고 기존 인프라와 통합해야 합니다.]]

### 2.1 데이터베이스 & 데이터 저장소 설정

- [ ] 데이터 작업 전에 데이터베이스 선택/설정 발생
- [ ] 데이터 작업 전에 스키마 정의 생성
- [ ] 해당하는 경우 마이그레이션 전략 정의
- [ ] 필요한 경우 시드 데이터 또는 초기 데이터 설정 포함
- [ ] [[BROWNFIELD ONLY]] 데이터베이스 마이그레이션 위험 식별 및 완화
- [ ] [[BROWNFIELD ONLY]] 역방향 호환성 보장

### 2.2 API & 서비스 구성

- [ ] 엔드포인트 구현 전에 API 프레임워크 설정
- [ ] 서비스 구현 전에 서비스 아키텍처 수립
- [ ] 보호된 라우트 전에 인증 프레임워크 설정
- [ ] 사용 전에 미들웨어 및 공통 유틸리티 생성
- [ ] [[BROWNFIELD ONLY]] 기존 시스템과의 API 호환성 유지
- [ ] [[BROWNFIELD ONLY]] 기존 인증과의 통합 보존

### 2.3 배포 파이프라인

- [ ] 배포 작업 전에 CI/CD 파이프라인 수립
- [ ] 사용 전에 Infrastructure as Code (IaC) 설정
- [ ] 초기에 환경 구성 정의
- [ ] 구현 전에 배포 전략 정의
- [ ] [[BROWNFIELD ONLY]] 배포 시 다운타임 최소화
- [ ] [[BROWNFIELD ONLY]] 블루-그린 또는 카나리 배포 구현

### 2.4 테스팅 인프라

- [ ] 테스트 작성 전에 테스팅 프레임워크 설치
- [ ] 테스트 구현 전에 테스트 환경 설정
- [ ] 테스팅 전에 모의 서비스 또는 데이터 정의
- [ ] [[BROWNFIELD ONLY]] 회귀 테스팅이 기존 기능을 커버
- [ ] [[BROWNFIELD ONLY]] 통합 테스팅이 신규-기존 연결을 검증

## 3. 외부 종속성 & 통합

[[LLM: 외부 종속성은 종종 진행을 차단합니다. 브라운필드의 경우, 새로운 종속성이 기존 것들과 충돌하지 않는지 확인하세요.]]

### 3.1 서드파티 서비스

- [ ] 필요한 서비스에 대한 계정 생성 단계 식별
- [ ] API 키 획득 프로세스 정의
- [ ] 자격 증명을 안전하게 저장하는 단계 포함
- [ ] 폴백 또는 오프라인 개발 옵션 고려
- [ ] [[BROWNFIELD ONLY]] 기존 서비스와의 호환성 확인
- [ ] [[BROWNFIELD ONLY]] 기존 통합에 대한 영향 평가

### 3.2 외부 API

- [ ] 외부 API와의 통합 지점 명확히 식별
- [ ] 외부 서비스와의 인증이 적절히 순서화됨
- [ ] API 제한 또는 제약사항 인정
- [ ] API 실패에 대한 백업 전략 고려
- [ ] [[BROWNFIELD ONLY]] 기존 API 종속성 유지

### 3.3 인프라 서비스

- [ ] 클라우드 리소스 프로비저닝이 적절히 순서화됨
- [ ] DNS 또는 도메인 등록 니즈 식별
- [ ] 필요한 경우 이메일 또는 메시징 서비스 설정 포함
- [ ] CDN 또는 정적 자산 호스팅 설정이 사용 전에 수행됨
- [ ] [[BROWNFIELD ONLY]] 기존 인프라 서비스 보존

## 4. UI/UX 고려사항 [[UI/UX ONLY]]

[[LLM: 프로젝트에 사용자 인터페이스 구성 요소가 포함된 경우에만 이 섹션을 평가하세요. 백엔드 전용 프로젝트의 경우 완전히 건너뛰세요.]]

### 4.1 디자인 시스템 설정

- [ ] UI 프레임워크와 라이브러리가 초기에 선택되고 설치됨
- [ ] 디자인 시스템 또는 컴포넌트 라이브러리 수립
- [ ] 스타일링 접근법 (CSS 모듈, styled-components 등) 정의
- [ ] 반응형 디자인 전략 수립
- [ ] 접근성 요구사항이 사전에 정의됨

### 4.2 프론트엔드 인프라

- [ ] 개발 전에 프론트엔드 빌드 파이프라인 구성
- [ ] 자산 최적화 전략 정의
- [ ] 프론트엔드 테스팅 프레임워크 설정
- [ ] 컴포넌트 개발 워크플로우 수립
- [ ] [[BROWNFIELD ONLY]] 기존 시스템과의 UI 일관성 유지

### 4.3 사용자 경험 플로우

- [ ] 구현 전에 사용자 여정 매핑
- [ ] 초기에 내비게이션 패턴 정의
- [ ] 오류 상태와 로딩 상태 계획
- [ ] 폼 유효성 검사 패턴 수립
- [ ] [[BROWNFIELD ONLY]] 기존 사용자 워크플로우 보존 또는 마이그레이션

## 5. 사용자/에이전트 책임

[[LLM: 명확한 소유권은 혼란을 방지합니다. 인간만이 할 수 있는 작업을 기반으로 작업이 적절히 할당되었는지 확인하세요.]]

### 5.1 사용자 행동

- [ ] 사용자 책임이 인간만의 작업으로 제한됨
- [ ] 외부 서비스의 계정 생성이 사용자에게 할당됨
- [ ] 구매 또는 결제 행동이 사용자에게 할당됨
- [ ] 자격 증명 제공이 사용자에게 적절히 할당됨

### 5.2 개발자 에이전트 행동

- [ ] 모든 코드 관련 작업이 개발자 에이전트에게 할당됨
- [ ] 자동화된 프로세스가 에이전트 책임으로 식별됨
- [ ] 구성 관리가 적절히 할당됨
- [ ] 테스팅과 검증이 적절한 에이전트에게 할당됨

## 6. 기능 순서 & 종속성

[[LLM: 종속성은 중요 경로를 생성합니다. 브라운필드의 경우, 새로운 기능이 기존 기능을 손상시키지 않는지 확인하세요.]]

### 6.1 기능적 종속성

- [ ] 다른 기능에 의존하는 기능이 올바르게 순서화됨
- [ ] 공유 컴포넌트가 사용 전에 구축됨
- [ ] 사용자 플로우가 논리적 진행을 따름
- [ ] 인증 기능이 보호된 기능보다 앞섬
- [ ] [[BROWNFIELD ONLY]] 기존 기능이 전체적으로 보존됨

### 6.2 기술적 종속성

- [ ] 하위 수준 서비스가 상위 수준보다 먼저 구축됨
- [ ] 라이브러리와 유틸리티가 사용 전에 생성됨
- [ ] 데이터 모델이 작업 전에 정의됨
- [ ] API 엔드포인트가 클라이언트 사용 전에 정의됨
- [ ] [[BROWNFIELD ONLY]] 통합 지점이 각 단계에서 테스트됨

### 6.3 교차 에픽 종속성

- [ ] 나중 에픽이 이전 에픽 기능을 기반으로 구축됨
- [ ] 어떤 에픽도 나중 에픽의 기능을 요구하지 않음
- [ ] 초기 에픽의 인프라가 일관되게 활용됨
- [ ] 점진적 가치 전달 유지
- [ ] [[BROWNFIELD ONLY]] 각 에픽이 시스템 무결성 유지

## 7. 위험 관리 [[BROWNFIELD ONLY]]

[[LLM: 이 섹션은 브라운필드 프로젝트에 매우 중요합니다. 무엇이 깨질 수 있는지에 대해 비관적으로 생각하세요.]]

### 7.1 파괴적 변경 위험

- [ ] 기존 기능을 손상시킬 위험 평가
- [ ] 데이터베이스 마이그레이션 위험 식별 및 완화
- [ ] API 파괴적 변경 위험 평가
- [ ] 성능 저하 위험 식별
- [ ] 보안 취약점 위험 평가

### 7.2 롤백 전략

- [ ] 스토리별로 롤백 절차 명확히 정의
- [ ] 기능 플래그 전략 구현
- [ ] 백업 및 복구 절차 업데이트
- [ ] 새 컴포넌트에 대한 모니터링 강화
- [ ] 롤백 트리거와 임계값 정의

### 7.3 사용자 영향 완화

- [ ] 기존 사용자 워크플로우의 영향 분석
- [ ] 사용자 소통 계획 개발
- [ ] 교육 자료 업데이트
- [ ] 지원 문서 포괄적 작성
- [ ] 사용자 데이터 마이그레이션 경로 검증

## 8. MVP 범위 정렬

[[LLM: MVP는 최소한의 실행 가능한 제품을 의미합니다. 브라운필드의 경우, 개선사항이 진정으로 필요한지 확인하세요.]]

### 8.1 핵심 목표 정렬

- [ ] PRD의 모든 핵심 목표가 다뤄짐
- [ ] 기능이 MVP 목표를 직접 지원함
- [ ] MVP 범위를 넘어서는 불필요한 기능 없음
- [ ] 중요 기능이 적절히 우선순위화됨
- [ ] [[BROWNFIELD ONLY]] 개선 복잡성이 정당화됨

### 8.2 사용자 여정 완전성

- [ ] 모든 중요 사용자 여정이 완전히 구현됨
- [ ] 엣지 케이스와 오류 시나리오가 다뤄짐
- [ ] 사용자 경험 고려사항 포함
- [ ] [[UI/UX ONLY]] 접근성 요구사항 통합
- [ ] [[BROWNFIELD ONLY]] 기존 워크플로우 보존 또는 개선

### 8.3 기술적 요구사항

- [ ] PRD의 모든 기술적 제약사항 다뤄짐
- [ ] 비기능 요구사항 통합
- [ ] 아키텍처 결정이 제약사항과 정렬됨
- [ ] 성능 고려사항 다뤄짐
- [ ] [[BROWNFIELD ONLY]] 호환성 요구사항 충족

## 9. 문서화 & 인수인계

[[LLM: 좋은 문서화는 원활한 개발을 가능하게 합니다. 브라운필드의 경우, 통합 지점의 문서화가 중요합니다.]]

### 9.1 개발자 문서화

- [ ] API 문서가 구현과 함께 생성됨
- [ ] 설정 지침이 포괄적임
- [ ] 아키텍처 결정이 문서화됨
- [ ] 패턴과 관례가 문서화됨
- [ ] [[BROWNFIELD ONLY]] 통합 지점이 상세히 문서화됨

### 9.2 사용자 문서화

- [ ] 필요한 경우 사용자 가이드 또는 도움말 문서 포함
- [ ] 오류 메시지와 사용자 피드백 고려
- [ ] 온보딩 플로우가 완전히 명시됨
- [ ] [[BROWNFIELD ONLY]] 기존 기능에 대한 변경사항 문서화

### 9.3 지식 전수

- [ ] [[BROWNFIELD ONLY]] 기존 시스템 지식 캡처
- [ ] [[BROWNFIELD ONLY]] 통합 지식 문서화
- [ ] 코드 리뷰 지식 공유 계획
- [ ] 운영팀에 배포 지식 전수
- [ ] 역사적 컨텍스트 보존

## 10. MVP 이후 고려사항

[[LLM: 성공을 위한 계획은 기술 부채를 방지합니다. 브라운필드의 경우, 개선사항이 미래 성장을 제한하지 않는지 확인하세요.]]

### 10.1 향후 개선사항

- [ ] MVP와 향후 기능 간의 명확한 분리
- [ ] 아키텍처가 계획된 개선사항을 지원함
- [ ] 기술 부채 고려사항 문서화
- [ ] 확장성 지점 식별
- [ ] [[BROWNFIELD ONLY]] 통합 패턴의 재사용 가능성

### 10.2 모니터링 & 피드백

- [ ] 필요한 경우 분석 또는 사용 추적 포함
- [ ] 사용자 피드백 수집 고려
- [ ] 모니터링과 알림 다뤄짐
- [ ] 성능 측정 통합
- [ ] [[BROWNFIELD ONLY]] 기존 모니터링 보존/강화

## 검증 요약

[[LLM: 최종 PO 검증 보고서 생성

프로젝트 유형에 적응하는 포괄적인 검증 보고서 생성:

1. 요약 보고서
   - 프로젝트 유형: [그린필드/브라운필드] with [UI/No UI]
   - 전반적인 준비도 (퍼센트)
   - Go/No-Go 권장사항
   - 중요 차단 이슈 수
   - 프로젝트 유형으로 인해 건너뛴 섹션

2. 프로젝트별 분석

   그린필드의 경우:
   - 설정 완성도
   - 종속성 순서화
   - MVP 범위 적절성
   - 개발 타임라인 실현 가능성

   브라운필드의 경우:
   - 통합 위험 수준 (높음/중간/낮음)
   - 기존 시스템 영향 평가
   - 롤백 준비도
   - 사용자 중단 가능성

3. 위험 평가
   - 심각도별 상위 5개 위험
   - 완화 권장사항
   - 이슈 해결의 타임라인 영향
   - [브라운필드] 특정 통합 위험

4. MVP 완성도
   - 핵심 기능 커버리지
   - 빠진 필수 기능
   - 범위 크리프 식별
   - 진정한 MVP vs 과도한 엔지니어링

5. 구현 준비도
   - 개발자 명확성 점수 (1-10)
   - 모호한 요구사항 수
   - 빠진 기술적 세부사항
   - [브라운필드] 통합 지점 명확성

6. 권장사항
   - 개발 전 반드시 수정
   - 품질을 위해 수정해야 함
   - 개선을 위해 고려
   - MVP 이후 연기

7. [브라운필드 전용] 통합 신뢰도
   - 기존 기능 보존에 대한 신뢰도
   - 롤백 절차 완성도
   - 통합 지점에 대한 모니터링 커버리지
   - 지원팀 준비도

보고서 제시 후, 사용자에게 다음을 원하는지 물어보세요:

- 실패한 섹션의 상세 분석
- 특정 스토리 재정렬 제안
- 위험 완화 전략
- [브라운필드] 통합 위험 심층 분석]]

### 카테고리 상태

| 카테고리                    | 상태  | 중요 이슈 |
| --------------------------- | ----- | --------- |
| 1. 프로젝트 설정 & 초기화   | _TBD_ |           |
| 2. 인프라 & 배포            | _TBD_ |           |
| 3. 외부 종속성 & 통합       | _TBD_ |           |
| 4. UI/UX 고려사항           | _TBD_ |           |
| 5. 사용자/에이전트 책임     | _TBD_ |           |
| 6. 기능 순서 & 종속성       | _TBD_ |           |
| 7. 위험 관리 (브라운필드)   | _TBD_ |           |
| 8. MVP 범위 정렬            | _TBD_ |           |
| 9. 문서화 & 인수인계        | _TBD_ |           |
| 10. MVP 이후 고려사항       | _TBD_ |           |

### 중요 결함

(검증 중에 채워질 예정)

### 권장사항

(검증 중에 채워질 예정)

### 최종 결정

- **승인됨**: 계획이 포괄적이고 적절히 순서화되어 구현 준비가 완료됨.
- **조건부**: 계획이 진행하기 전에 특정 조정이 필요함.
- **거부됨**: 계획이 중요한 결함을 해결하기 위한 상당한 수정이 필요함.
