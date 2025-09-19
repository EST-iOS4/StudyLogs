//
//  OperatorExample.swift
//  HelloWorld
//
//  Created by Jungman Bae on 9/19/25.
//

import SwiftUI
import Combine

// @Observable 매크로를 사용하면, 해당 클래스의 저장 프로퍼티 변경을
// SwiftUI가 자동으로 추적할 수 있게 도와줍니다.
// - iOS 17 이상에서 사용할 수 있는 Observation 프레임워크 기반 매크로입니다.
// - 이 클래스 내부의 프로퍼티가 변경되면, 해당 프로퍼티를 구독하는 View가 갱신됩니다.
@Observable
class SearchViewModel {
  // 사용자가 입력한 검색어.
  // didSet에서 변경된 값을 Combine 스트림으로 흘려보내기 위해 subject로 전송합니다.
  var searchText = "" {
    didSet {
      // searchText 변경 → subject 로 전송
      // 텍스트 필드의 바인딩을 통해 사용자가 타이핑할 때마다 이 지점이 호출됩니다.
      searchTextSubject.send(searchText)
    }
  }

  // 화면에 표시할 검색 결과 목록.
  // 외부에서 임의로 수정하지 못하도록 private(set)으로 설정합니다.
  private(set) var searchResults: [String] = []

  // 검색 대상이 되는 전체 아이템 목록(예시 데이터).
  private let allItems = [
    "사과", "사과주스", "바나나", "바나나우유", "오렌지",
    "오렌지주스", "포도", "포도주스", "딸기", "딸기우유"
  ]

  // Combine 스트림용 subject.
  // - PassthroughSubject는 값을 저장하지 않고, 새로 들어오는 값만 구독자에게 전달합니다.
  // - 출력 타입은 String(검색어), 실패 타입은 Never로 설정했습니다.
  private let searchTextSubject = PassthroughSubject<String, Never>()

  // Combine 구독을 보관하기 위한 저장소.
  // - 구독이 해제되지 않으면 메모리 누수가 발생할 수 있으므로 Set으로 관리합니다.
  private var cancellables = Set<AnyCancellable>()

  init() {
    // searchTextSubject로 들어오는 텍스트 변경 이벤트 스트림에 대해
    // 여러 Combine 연산자를 적용하여 최종적으로 searchResults를 업데이트합니다.
    searchTextSubject
      // debounce: 사용자가 입력을 멈춘 후 500ms 동안 추가 입력이 없을 때만 다음 단계로 전달합니다.
      // - 빠른 타이핑 중 불필요한 필터링/렌더링을 줄여 성능을 개선합니다.
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)

      // removeDuplicates: 이전 값과 동일한 문자열이면 무시합니다.
      // - 같은 내용의 반복 전송으로 인한 불필요한 연산을 방지합니다.
      .removeDuplicates()

      // map: 현재 검색어(term)를 받아서 필터링된 결과 배열을 생성합니다.
      .map { [allItems] term in
        // 공백/개행을 제거한 뒤 비어 있다면 전체 목록을 반환하고,
        // 비어 있지 않다면 해당 검색어를 포함하는 아이템만 필터링합니다.
        // - contains는 단순 서브스트링 포함 여부를 확인합니다.
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
          ? allItems
          : allItems.filter { $0.contains(trimmed) }
      }

      // assign: 위에서 변환된 결과 배열을 self.searchResults에 할당합니다.
      // - self는 클래스 인스턴스이므로 on: self를 사용합니다.
      .assign(to: \.searchResults, on: self)

      // store: 구독을 cancellables에 저장하여 ViewModel의 생명주기 동안 유지합니다.
      .store(in: &cancellables)

    // 초기값도 반영:
    // - ViewModel 생성 직후 현재 searchText(초기값 "")을 스트림에 한 번 흘려보내
    //   초기 searchResults가 즉시 계산되도록 합니다.
    searchTextSubject.send(searchText)
  }
}

struct OperatorExample: View {
  // @State로 SearchViewModel을 보유합니다.
  // - @Observable을 사용하므로 View는 viewModel의 변경 사항을 자동으로 감지합니다.
  @State private var viewModel = SearchViewModel()

  var body: some View {
    VStack {
      // 검색어 입력 필드.
      // - 텍스트 바인딩을 통해 입력이 변경될 때마다 viewModel.searchText가 업데이트됩니다.
      // - 위에서 정의한 didSet이 호출되어 Combine 파이프라인으로 전파됩니다.
      TextField("검색어 입력", text: $viewModel.searchText)
        .textFieldStyle(.roundedBorder)

      // 검색 결과 리스트.
      // - viewModel.searchResults가 변경될 때마다 리스트가 갱신됩니다.
      List(viewModel.searchResults, id: \.self) { item in
        Text(item)
      }
    }
    .padding()
  }
}

#Preview {
  OperatorExample()
}
