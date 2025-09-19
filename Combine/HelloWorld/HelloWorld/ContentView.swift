//
//  ContentView.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/19/25.
//

import SwiftUI
import Combine // Combine 프레임워크: 비동기 이벤트(시간, 네트워크 응답, 사용자 입력 등)를
               // Publisher(발행자) → Subscriber(구독자) 모델로 처리하는 선언적 API를 제공.
// 이 예제에서는 Timer.publish로 "1초마다 현재 시각을 발행"하는 Publisher를 만들고,
// SwiftUI의 .onReceive(Subscriber 역할)를 통해 값을 받아 @State를 업데이트합니다.
struct ContentView: View {
  // SwiftUI의 @State: View의 상태를 저장하고, 값이 변경되면 View를 다시 그리도록 트리거합니다.
  @State private var currentTime = Date()

  // Combine의 Timer Publisher 생성:
  // - Timer.publish(every:on:in:)은 지정한 간격마다 Date 값을 발행하는 Publisher를 리턴합니다.
  // - on: .main → 메인 런루프에서 타이머가 동작(주로 UI 업데이트를 위해 메인 스레드 사용)
  // - in: .common → common 모드에서 타이머가 동작(스크롤 등 다른 런루프 모드에서도 적절히 동작)
  // - autoconnect() → 명시적으로 .connect()를 호출하지 않아도, 구독이 발생하는 순간 자동으로 연결(타이머 시작)
  //
  // 즉, View가 .onReceive로 이 Publisher를 구독하면, 타이머는 자동으로 시작되고
  // 매 1초마다 새로운 Date 값을 발행합니다.
  let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
    .autoconnect()

  // 시간 표시용 포매터
  private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter
  }()

  var body: some View {
    // 현재 시간을 문자열로 포매팅해 보여줍니다.
    Text("현재 시간: \(currentTime, formatter: timeFormatter)")
      // .onReceive(_:): SwiftUI View에서 특정 Publisher를 구독하고, 새 값이 들어올 때마다 클로저를 실행.
      // - 여기서는 timerPublisher가 매 1초마다 Date 값을 발행.
      // - time 파라미터로 전달된 값(Date)을 @State인 currentTime에 대입 → View 렌더링 갱신.
      //
      // Combine의 흐름:
      // [Publisher: Timer] --(1초마다 Date 발행)--> [Subscriber: onReceive 핸들러]
      // --> currentTime 업데이트 --> SwiftUI가 상태 변화를 감지하고 body 재계산 → 화면 시간 갱신
      .onReceive(timerPublisher) { time in
        currentTime = time
      }
  }
}

#Preview {
    ContentView()
}
