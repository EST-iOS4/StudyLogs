# /document-project Task

When this command is used, execute the following task:

<!-- Powered by BMAD™ Core -->

# Document an Existing Project

## Purpose

Generate comprehensive documentation for existing projects optimized for AI development agents. This task creates structured reference materials that enable AI agents to understand project context, conventions, and patterns for effective contribution to any codebase.

## Task Instructions

### 1. Initial Project Analysis

**CRITICAL:** First, check if a PRD or requirements document exists in context. If yes, use it to focus your documentation efforts on relevant areas only.

**IF PRD EXISTS**:

- Review the PRD to understand what enhancement/feature is planned
- Identify which modules, services, or areas will be affected
- Focus documentation ONLY on these relevant areas
- Skip unrelated parts of the codebase to keep docs lean

**IF NO PRD EXISTS**:
Ask the user:

"I notice you haven't provided a PRD or requirements document. To create more focused and useful documentation, I recommend one of these options:

1. **Create a PRD first** - Would you like me to help create a brownfield PRD before documenting? This helps focus documentation on relevant areas.

2. **Provide existing requirements** - Do you have a requirements document, epic, or feature description you can share?

3. **Describe the focus** - Can you briefly describe what enhancement or feature you're planning? For example:
   - 'Adding payment processing to the user service'
   - 'Refactoring the authentication module'
   - 'Integrating with a new third-party API'

4. **Document everything** - Or should I proceed with comprehensive documentation of the entire codebase? (Note: This may create excessive documentation for large projects)

Please let me know your preference, or I can proceed with full documentation if you prefer."

Based on their response:

- If they choose option 1-3: Use that context to focus documentation
- If they choose option 4 or decline: Proceed with comprehensive analysis below

Begin by conducting analysis of the existing project. Use available tools to:

1. **Project Structure Discovery**: Examine the root directory structure, identify main folders, and understand the overall organization
2. **Technology Stack Identification**: Look for package.json, requirements.txt, Cargo.toml, pom.xml, etc. to identify languages, frameworks, and dependencies
3. **Build System Analysis**: Find build scripts, CI/CD configurations, and development commands
4. **Existing Documentation Review**: Check for README files, docs folders, and any existing documentation
5. **Code Pattern Analysis**: Sample key files to understand coding patterns, naming conventions, and architectural approaches

Ask the user these elicitation questions to better understand their needs:

- What is the primary purpose of this project?
- Are there any specific areas of the codebase that are particularly complex or important for agents to understand?
- What types of tasks do you expect AI agents to perform on this project? (e.g., bug fixes, feature additions, refactoring, testing)
- Are there any existing documentation standards or formats you prefer?
- What level of technical detail should the documentation target? (junior developers, senior developers, mixed team)
- Is there a specific feature or enhancement you're planning? (This helps focus documentation)

### 2. Deep Codebase Analysis

CRITICAL: Before generating documentation, conduct extensive analysis of the existing codebase:

1. **Explore Key Areas**:
   - Entry points (main files, index files, app initializers)
   - Configuration files and environment setup
   - Package dependencies and versions
   - Build and deployment configurations
   - Test suites and coverage

2. **Ask Clarifying Questions**:
   - "I see you're using [technology X]. Are there any custom patterns or conventions I should document?"
   - "What are the most critical/complex parts of this system that developers struggle with?"
   - "Are there any undocumented 'tribal knowledge' areas I should capture?"
   - "What technical debt or known issues should I document?"
   - "Which parts of the codebase change most frequently?"

3. **Map the Reality**:
   - Identify ACTUAL patterns used (not theoretical best practices)
   - Find where key business logic lives
   - Locate integration points and external dependencies
   - Document workarounds and technical debt
   - Note areas that differ from standard patterns

**IF PRD PROVIDED**: Also analyze what would need to change for the enhancement

### 3. Core Documentation Generation

[[LLM: Generate a comprehensive BROWNFIELD architecture document that reflects the ACTUAL state of the codebase.

**CRITICAL**: This is NOT an aspirational architecture document. Document what EXISTS, including:

- Technical debt and workarounds
- Inconsistent patterns between different parts
- Legacy code that can't be changed
- Integration constraints
- Performance bottlenecks

**문서 구조**:

## [프로젝트 이름] 브라운필드 아키텍처 문서

### 소개

이 문서는 기술 부채, 우회책, 실제 패턴을 포함한 [프로젝트 이름] 코드베이스의 현재 상태를 포착합니다. 개선사항을 작업하는 AI 에이전트를 위한 참조 자료 역할을 합니다.

#### 문서 범위

[PRD가 제공된 경우: "{개선사항 설명}과 관련된 영역에 집중"]
[PRD가 없는 경우: "전체 시스템의 포괄적 문서화"]

#### 변경 로그

| 날짜   | 버전 | 설명                   | 작성자     |
| ------ | ---- | ---------------------- | ---------- |
| [날짜] | 1.0  | 초기 브라운필드 분석   | [분석가]   |

### 빠른 참조 - 주요 파일 및 진입점

#### 시스템 이해를 위한 중요 파일

- **메인 진입점**: `src/index.js` (또는 실제 진입점)
- **구성**: `config/app.config.js`, `.env.example`
- **핵심 비즈니스 로직**: `src/services/`, `src/domain/`
- **API 정의**: `src/routes/` 또는 OpenAPI 스펙 링크
- **데이터베이스 모델**: `src/models/` 또는 스키마 파일 링크
- **주요 알고리즘**: [복잡한 로직이 있는 특정 파일 나열]

#### PRD가 제공된 경우 - 개선사항 영향 영역

[계획된 개선사항에 의해 영향받을 파일/모듈 강조]

### 상위 수준 아키텍처

#### 기술적 요약

#### 실제 기술 스택 (package.json/requirements.txt에서)

| 카테고리  | 기술       | 버전    | 참고사항               |
| --------- | ---------- | ------- | ---------------------- |
| 런타임    | Node.js    | 16.x    | [제약사항]             |
| 프레임워크| Express    | 4.18.2  | [커스텀 미들웨어?]     |
| 데이터베이스| PostgreSQL | 13      | [연결 풀링 설정]      |

등등...

#### 저장소 구조 현실 확인

- 유형: [모노레포/폴리레포/하이브리드]
- 패키지 매니저: [npm/yarn/pnpm]
- 주목할 점: [특이한 구조 결정사항]

### 소스 트리 및 모듈 구성

#### 프로젝트 구조 (실제)

```text
project-root/
├── src/
│   ├── controllers/     # HTTP 요청 핸들러
│   ├── services/        # 비즈니스 로직 (참고: 사용자와 결제 서비스 간 일관성 없는 패턴)
│   ├── models/          # 데이터베이스 모델 (Sequelize)
│   ├── utils/           # 혼합 - 리팩토링 필요
│   └── legacy/          # 수정 금지 - 오래된 결제 시스템이 여전히 사용됨
├── tests/               # Jest 테스트 (60% 커버리지)
├── scripts/             # 빌드 및 배포 스크립트
└── config/              # 환경 구성
```

#### 주요 모듈과 목적

- **사용자 관리**: `src/services/userService.js` - 모든 사용자 작업 처리
- **인증**: `src/middleware/auth.js` - JWT 기반, 커스텀 구현
- **결제 처리**: `src/legacy/payment.js` - 중요: 리팩토링 금지, 강하게 결합됨
- **[실제 파일과 함께 다른 주요 모듈 나열]**

### 데이터 모델 및 API

#### 데이터 모델

중복 대신 실제 모델 파일 참조:

- **사용자 모델**: `src/models/User.js` 참조
- **주문 모델**: `src/models/Order.js` 참조
- **관련 타입**: `src/types/`의 TypeScript 정의

#### API 명세

- **OpenAPI 스펙**: `docs/api/openapi.yaml` (존재하는 경우)
- **Postman 컬렉션**: `docs/api/postman-collection.json`
- **수동 엔드포인트**: [발견된 문서화되지 않은 엔드포인트 나열]

### 기술 부채 및 알려진 문제

#### 중요한 기술 부채

1. **결제 서비스**: `src/legacy/payment.js`의 레거시 코드 - 강하게 결합됨, 테스트 없음
2. **사용자 서비스**: 다른 서비스와 다른 패턴, 프로미스 대신 콜백 사용
3. **데이터베이스 마이그레이션**: 수동 추적, 적절한 마이그레이션 도구 없음
4. **[기타 중요한 부채]**

#### 우회책 및 함정

- **환경 변수**: 스테이징에서도 `NODE_ENV=production` 설정 필요 (역사적 이유)
- **데이터베이스 연결**: 연결 풀이 10으로 하드코딩됨, 변경 시 결제 서비스 중단
- **[개발자가 알아야 할 기타 우회책]**

### 통합 지점 및 외부 종속성

#### 외부 서비스

| 서비스   | 목적     | 통합 유형 | 주요 파일                      |
| -------- | -------- | --------- | ------------------------------ |
| Stripe   | 결제     | REST API  | `src/integrations/stripe/`     |
| SendGrid | 이메일   | SDK       | `src/services/emailService.js` |

등등...

#### 내부 통합 지점

- **프론트엔드 통신**: 포트 3000의 REST API, 특정 헤더 요구
- **백그라운드 작업**: Redis 큐, `src/workers/` 참조
- **[기타 통합]**

### 개발 및 배포

#### 로컬 개발 설정

1. 작동하는 실제 단계 (이상적인 단계가 아님)
2. 설정의 알려진 문제
3. 필요한 환경 변수 (`.env.example` 참조)

#### 빌드 및 배포 프로세스

- **빌드 명령**: `npm run build` (`webpack.config.js`의 webpack 구성)
- **배포**: `scripts/deploy.sh`를 통한 수동 배포
- **환경**: 개발, 스테이징, 프로덕션 (`config/environments/` 참조)

### 테스트 현실

#### 현재 테스트 커버리지

- 단위 테스트: 60% 커버리지 (Jest)
- 통합 테스트: 최소, `tests/integration/`에 있음
- E2E 테스트: 없음
- 수동 테스트: 주요 QA 방법

#### 테스트 실행

```bash
npm test           # 단위 테스트 실행
npm run test:integration  # 통합 테스트 실행 (로컬 DB 필요)
```

### 개선사항 PRD가 제공된 경우 - 영향 분석

#### 수정이 필요한 파일

개선사항 요구사항을 기반으로 다음 파일들이 영향받을 것입니다:

- `src/services/userService.js` - 새 사용자 필드 추가
- `src/models/User.js` - 스키마 업데이트
- `src/routes/userRoutes.js` - 새 엔드포인트
- [등등...]

#### 필요한 새 파일/모듈

- `src/services/newFeatureService.js` - 새 비즈니스 로직
- `src/models/NewFeature.js` - 새 데이터 모델
- [등등...]

#### 통합 고려사항

- 기존 인증 미들웨어와 통합 필요
- `src/utils/responseFormatter.js`의 기존 응답 형식 준수 필요
- [기타 통합 지점]

### 부록 - 유용한 명령 및 스크립트

#### 자주 사용하는 명령

```bash
npm run dev         # 개발 서버 시작
npm run build       # 프로덕션 빌드
npm run migrate     # 데이터베이스 마이그레이션 실행
npm run seed        # 테스트 데이터 시드
```

#### 디버깅 및 문제해결

- **로그**: 애플리케이션 로그는 `logs/app.log` 확인
- **디버그 모드**: 상세 로깅을 위해 `DEBUG=app:*` 설정
- **일반적인 문제**: `docs/troubleshooting.md` 참조]]

### 4. 문서 전달

1. **웹 UI에서 (Gemini, ChatGPT, Claude)**:
   - 전체 문서를 하나의 응답으로 제시 (너무 길면 여러 개)
   - 사용자에게 `docs/brownfield-architecture.md` 또는 `docs/project-architecture.md`로 복사하여 저장하도록 알림
   - 필요한 경우 나중에 IDE에서 샤드할 수 있다고 언급

2. **IDE 환경에서**:
   - `docs/brownfield-architecture.md`로 문서 생성
   - 이 단일 문서가 모든 아키텍처 정보를 포함한다고 사용자에게 알림
   - 원하는 경우 나중에 PO 에이전트를 사용하여 샤드 가능

문서는 향후 에이전트들이 다음을 이해할 수 있을 만큼 포괄적이어야 합니다:

- 시스템의 실제 상태 (이상화되지 않은)
- 주요 파일과 로직을 찾을 위치
- 어떤 기술 부채가 존재하는지
- 어떤 제약사항을 준수해야 하는지
- PRD가 제공된 경우: 개선사항을 위해 변경해야 할 것]]

### 5. 품질 보증

중요: 문서를 확정하기 전:

1. **정확성 확인**: 모든 기술적 세부사항이 실제 코드베이스와 일치하는지 확인
2. **완전성 검토**: 모든 주요 시스템 구성요소가 문서화되었는지 확인
3. **초점 검증**: 사용자가 범위를 제공한 경우, 관련 영역이 강조되었는지 확인
4. **명확성 평가**: AI 에이전트를 위한 설명이 명확한지 확인
5. **탐색**: 문서가 쉬운 참조를 위한 명확한 섹션 구조를 갖는지 확인

주요 섹션 후에 고급 유도 질문 태스크를 적용하여 사용자 피드백을 기반으로 개선하세요.

## 성공 기준

- 단일 포괄적 브라운필드 아키텍처 문서 생성
- 문서가 기술 부채와 우회책을 포함한 현실을 반영
- 주요 파일과 모듈이 실제 경로와 함께 참조됨
- 모델/API가 콘텐츠를 중복하는 대신 소스 파일을 참조
- PRD가 제공된 경우: 변경해야 할 것을 보여주는 명확한 영향 분석
- 문서가 AI 에이전트가 실제 코드베이스를 탐색하고 이해할 수 있게 함
- 기술적 제약사항과 "함정"이 명확히 문서화됨

## 참고사항

- 이 태스크는 시스템의 참된 상태를 포착하는 하나의 문서를 생성
- 가능한 경우 콘텐츠를 중복하는 대신 실제 파일을 참조
- 기술 부채, 우회책, 제약사항을 정직하게 문서화
- PRD가 있는 브라운필드 프로젝트의 경우: 명확한 개선사항 영향 분석 제공
- 목표는 실제 작업을 하는 AI 에이전트를 위한 실용적 문서화
