const { initializeApp } = require('firebase-admin/app');
const { getFirestore, Timestamp } = require('firebase-admin/firestore');

// Firebase Admin SDK 초기화 (에뮬레이터용)
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
const app = initializeApp({
  projectId: 'est-ios04', // 에뮬레이터에서는 아무 프로젝트 ID나 사용 가능
});

const db = getFirestore(app);

// 더미 할 일 제목들
const todoTitles = [
  // 업무 관련
  '프로젝트 기획서 작성하기', '회의 참석하기', '보고서 제출하기', '이메일 확인하기', '팀 미팅 준비하기',
  '클라이언트와 통화하기', '예산 검토하기', '마케팅 전략 수립하기', '제품 테스트하기', '버그 수정하기',
  '코드 리뷰하기', '새 기능 개발하기', 'API 문서 작성하기', '데이터베이스 최적화하기', '보안 점검하기',
  
  // 학습 관련
  'Swift 튜토리얼 완료하기', 'Combine 공부하기', 'SwiftUI 연습하기', 'iOS 앱 개발 강의 수강하기',
  'UIKit 복습하기', 'Core Data 학습하기', '알고리즘 문제 풀기', '영어 공부하기', '온라인 강의 듣기',
  '기술 블로그 읽기', '코딩 테스트 준비하기', 'GitHub 프로젝트 정리하기', '포트폴리오 업데이트하기',
  
  // 개인 생활
  '운동하기', '독서하기', '산책하기', '요리하기', '청소하기', '빨래하기', '쇼핑하기', '친구 만나기',
  '영화 보기', '음악 듣기', '게임하기', '여행 계획 세우기', '사진 정리하기', '일기 쓰기', '명상하기',
  
  // 건강 관리
  '병원 예약하기', '약 복용하기', '건강검진 받기', '치과 치료받기', '안과 검사받기', '피부과 방문하기',
  '헬스장 등록하기', '요가 수업 듣기', '다이어트 계획 세우기', '금연하기', '금주하기', '수면 패턴 개선하기',
  
  // 집안일
  '방 정리하기', '화분에 물 주기', '가전제품 점검하기', '인터넷 요금 납부하기', '전기요금 납부하기',
  '가스요금 납부하기', '관리비 납부하기', '보험료 납부하기', '세금 신고하기', '은행 업무 보기',
  
  // 취미 및 여가
  '기타 연습하기', '그림 그리기', '사진 촬영하기', '블로그 포스팅하기', 'YouTube 영상 시청하기',
  'Netflix 드라마 보기', '팟캐스트 듣기', '퍼즐 맞추기', '보드게임 하기', '카페 가기',
  
  // 사회 활동
  '자원봉사 참여하기', '동호회 모임 참석하기', '네트워킹 이벤트 참가하기', '세미나 참석하기',
  '컨퍼런스 등록하기', '멘토링 받기', '스터디 그룹 참여하기', '토론회 참석하기',
  
  // 창의적 활동
  '시 쓰기', '소설 읽기', '창작 활동하기', '아이디어 노트 작성하기', '브레인스토밍하기',
  '마인드맵 그리기', '새로운 레시피 시도하기', 'DIY 프로젝트 시작하기', '가드닝하기',
  
  // 기타
  '차량 정비 받기', '보험 갱신하기', '계좌 정리하기', '비밀번호 변경하기', '백업 파일 정리하기',
  '구독 서비스 정리하기', '앱 업데이트하기', '컴퓨터 청소하기', '데이터 정리하기', '파일 백업하기',
  '새해 계획 세우기', '목표 점검하기', '감사 인사 보내기', '선물 준비하기', '생일 축하하기'
];

// 랜덤 날짜 생성 함수 (지난 30일부터 앞으로 7일까지)
function getRandomCreatedDate() {
  const today = new Date();
  const pastDays = 30; // 지난 30일
  const futureDays = 7; // 앞으로 7일
  
  const start = new Date(today.getTime() - (pastDays * 24 * 60 * 60 * 1000));
  const end = new Date(today.getTime() + (futureDays * 24 * 60 * 60 * 1000));
  
  const randomTime = start.getTime() + Math.random() * (end.getTime() - start.getTime());
  return new Date(randomTime);
}

// 랜덤 배열 요소 선택 함수
function getRandomElement(array) {
  return array[Math.floor(Math.random() * array.length)];
}

// 랜덤 완료 상태 생성 (70% 미완료, 30% 완료)
function getRandomCompleted() {
  return Math.random() < 0.3; // 30% 확률로 완료
}

// 더미 데이터 생성 및 Firestore에 추가
async function generateTodoItemsData() {
  console.log('📝 TodoItem 더미 데이터 100개 생성을 시작합니다...');
  
  const batch = db.batch();
  
  for (let i = 1; i <= 100; i++) {
    const todoRef = db.collection('todos').doc();
    
    const todoData = {
      title: getRandomElement(todoTitles),
      completed: getRandomCompleted(),
      createdAt: Timestamp.fromDate(getRandomCreatedDate()),
    };
    
    batch.set(todoRef, todoData);
    
    if (i % 10 === 0) {
      console.log(`✅ ${i}개 TodoItem 데이터 준비 완료...`);
    }
  }
  
  try {
    await batch.commit();
    console.log('🎉 100개의 TodoItem 데이터가 성공적으로 Firestore에 추가되었습니다!');
    
    // 생성된 데이터 확인
    const snapshot = await db.collection('todos').limit(5).get();
    console.log('\n📋 생성된 데이터 샘플 (처음 5개):');
    snapshot.forEach((doc, index) => {
      const data = doc.data();
      const createdDate = data.createdAt.toDate().toISOString().split('T')[0];
      const status = data.completed ? '✅ 완료' : '⏳ 미완료';
      console.log(`${index + 1}. ${data.title} - ${status} (${createdDate})`);
    });
    
    // 완료/미완료 통계 확인
    const allSnapshot = await db.collection('todos').get();
    let completedCount = 0;
    let pendingCount = 0;
    
    allSnapshot.forEach((doc) => {
      const data = doc.data();
      if (data.completed) {
        completedCount++;
      } else {
        pendingCount++;
      }
    });
    
    console.log(`\n📊 통계:`);
    console.log(`   총 ${allSnapshot.size}개의 TodoItem이 저장되었습니다.`);
    console.log(`   완료: ${completedCount}개 (${((completedCount / allSnapshot.size) * 100).toFixed(1)}%)`);
    console.log(`   미완료: ${pendingCount}개 (${((pendingCount / allSnapshot.size) * 100).toFixed(1)}%)`);
    
  } catch (error) {
    console.error('❌ 데이터 추가 중 오류가 발생했습니다:', error);
  } finally {
    process.exit(0);
  }
}

// 스크립트 실행
generateTodoItemsData();