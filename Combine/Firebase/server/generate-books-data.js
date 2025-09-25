const { initializeApp } = require('firebase-admin/app');
const { getFirestore, Timestamp } = require('firebase-admin/firestore');

// Firebase Admin SDK 초기화 (에뮬레이터용)
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
const app = initializeApp({
  projectId: 'est-ios04', // 에뮬레이터에서는 아무 프로젝트 ID나 사용 가능
});

const db = getFirestore(app);

// 더미 책 제목들
const bookTitles = [
  '해리 포터와 마법사의 돌', '반지의 제왕', '어린 왕자', '1984', '위대한 개츠비',
  '자바스크립트 완벽 가이드', 'Swift로 하는 iOS 개발', '클린 코드', '리팩토링',
  '객체지향의 사실과 오해', '실용주의 프로그래머', '코딩 인터뷰 완전 분석',
  '알고리즘 문제 해결 전략', '컴퓨터 프로그램의 구조와 해석', 'HTTP 완벽 가이드',
  '모던 자바스크립트 Deep Dive', 'React를 다루는 기술', 'Vue.js 프로젝트',
  '스프링 부트와 AWS로 혼자 구현하는 웹 서비스', 'Node.js 교과서',
  '데이터베이스 시스템', '운영체제 개념', '컴퓨터 네트워킹', '소프트웨어 공학',
  '인공지능', '머신러닝', '딥러닝', '데이터 과학', '빅데이터',
  '블록체인 혁명', '사물인터넷', '클라우드 컴퓨팅', '사이버 보안',
  '디지털 전환', '아키텍처 패턴', '마이크로서비스', '도커와 쿠버네티스',
  '애자일 개발', 'DevOps', 'TDD 실천법', 'DDD Start!',
  '함수형 프로그래밍', '리액티브 프로그래밍', '동시성 프로그래밍',
  '성능 최적화', '보안 프로그래밍', '게임 개발', '모바일 앱 개발',
  '웹 개발', 'UI/UX 디자인', '데이터 시각화', 'API 설계',
  '프로젝트 관리', '팀 리더십', '기술 창업', '스타트업',
  '피터 팬', '이상한 나라의 앨리스', '셜록 홈즈', '로미오와 줄리엣',
  '햄릿', '오셀로', '리어왕', '맥베스', '한여름 밤의 꿈',
  '오만과 편견', '제인 에어', '폭풍의 언덕', '노인과 바다',
  '누구를 위하여 종은 울리나', '태양은 다시 떠오른다', '무기여 잘 있거라',
  '호밀밭의 파수꾼', '앵무새 죽이기', '분노의 포도', '동물농장',
  '멋진 신세계', '화씨 451', '시간 기계', '투명인간',
  '지킬 박사와 하이드 씨', '드라큘라', '프랑켄슈타인', '보물섬',
  '모비딕', '걸리버 여행기', '로빈슨 크루소', '돈키호테',
  '몬테크리스토 백작', '레 미제라블', '파리의 노트르담', '삼총사',
  '안나 카레니나', '전쟁과 평화', '죄와 벌', '카라마조프 가의 형제들',
  '바람과 함께 사라지다', '카사블랑카', '시민 케인', '대부',
  '쇼생크 탈출', '포레스트 검프', '타이타닉', '아바타',
  '스타워즈', '매트릭스', '인셉션', '인터스텔라',
  '어벤져스', '아이언맨', '배트맨', '슈퍼맨',
  '스파이더맨', '원더우먼', '블랙 팬서', '토르',
  '캡틴 아메리카', '헐크', '엑스맨', '데드풀'
];

// 더미 작가 이름들
const authors = [
  '김철수', '이영희', '박민수', '정수진', '최현우',
  '한지민', '송태현', '윤서연', '임동혁', '장미라',
  'John Smith', 'Jane Doe', 'Michael Johnson', 'Emily Davis', 'David Wilson',
  'Sarah Brown', 'Robert Miller', 'Lisa Anderson', 'James Taylor', 'Mary White',
  '다니엘 스틸', '스티븐 킹', '조앤 롤링', 'J.R.R. 톨킨', '어니스트 헤밍웨이',
  '윌리엄 셰익스피어', '찰스 디킨스', '제인 오스틴', '마크 트웨인', '에드거 앨런 포',
  '아서 코난 도일', '아가사 크리스티', '조지 오웰', '알더스 헉슬리', '레이 브래드버리',
  'H.G. 웰스', '줄 베른', '알렉상드르 뒤마', '빅토르 위고', '레프 톨스토이',
  '표도르 도스토예프스키', '안톤 체호프', '이반 투르게네프', '니콜라이 고골', '알렉산드르 푸시킨',
  '괴테', '토마스 만', '헤르만 헤세', '프란츠 카프카', '제임스 조이스'
];

// 랜덤 날짜 생성 함수 (1900년부터 2024년까지)
function getRandomDate() {
  const start = new Date(1900, 0, 1);
  const end = new Date(2024, 11, 31);
  const randomTime = start.getTime() + Math.random() * (end.getTime() - start.getTime());
  return new Date(randomTime);
}

// 랜덤 배열 요소 선택 함수
function getRandomElement(array) {
  return array[Math.floor(Math.random() * array.length)];
}

// 더미 데이터 생성 및 Firestore에 추가
async function generateBooksData() {
  console.log('📚 책 더미 데이터 100개 생성을 시작합니다...');
  
  const batch = db.batch();
  
  for (let i = 1; i <= 100; i++) {
    const bookRef = db.collection('books').doc();
    
    const bookData = {
      title: getRandomElement(bookTitles),
      author: getRandomElement(authors),
      publishedDate: Timestamp.fromDate(getRandomDate()), // Firebase Timestamp 타입
      createdAt: Timestamp.now(),
      id: i
    };
    
    batch.set(bookRef, bookData);
    
    if (i % 10 === 0) {
      console.log(`📖 ${i}개 책 데이터 준비 완료...`);
    }
  }
  
  try {
    await batch.commit();
    console.log('✅ 100개의 책 데이터가 성공적으로 Firestore에 추가되었습니다!');
    
    // 생성된 데이터 확인
    const snapshot = await db.collection('books').limit(5).get();
    console.log('\n📋 생성된 데이터 샘플 (처음 5개):');
    snapshot.forEach((doc, index) => {
      const data = doc.data();
      const publishedDate = data.publishedDate.toDate().toISOString().split('T')[0];
      console.log(`${index + 1}. ${data.title} - ${data.author} (${publishedDate})`);
    });
    
    // 전체 개수 확인
    const countSnapshot = await db.collection('books').count().get();
    console.log(`\n📊 총 ${countSnapshot.data().count}개의 책이 저장되었습니다.`);
    
  } catch (error) {
    console.error('❌ 데이터 추가 중 오류가 발생했습니다:', error);
  } finally {
    process.exit(0);
  }
}

// 스크립트 실행
generateBooksData();