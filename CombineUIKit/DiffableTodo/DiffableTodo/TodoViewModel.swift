//
//  TodoViewModel.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//
import Combine
import Foundation

final class TodoViewModel {
  @Published var todos: [TodoItem] = []
  @Published var hasNext: Bool = false
  @Published private(set) var isLoadingNext: Bool = false

  var service = NetworkTodoService()

  private var currentPage: Int = 0
  var cancellables = Set<AnyCancellable>()

  init() {
    // 첫 페이지 로드
    service.fetchTodos(page: 1)
      .receive(on: DispatchQueue.main)
      .sink( receiveCompletion: { completion in
        if case .failure(let error) = completion {
          print("오류: \(error)")
        }
      }, receiveValue: { [weak self] response in
        guard let self else { return }
        self.todos = response.todos
        self.hasNext = response.pagination.hasNext
        self.currentPage = response.pagination.currentPage
      })
      .store(in: &cancellables)
  }

  func addTodo(_ title: String) {
//    todos.append(TodoItem(title: title))
  }

  func toggleTodo(id: TodoItem.ID) {
//    guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
//    todos[index].isCompleted.toggle()
  }

  // 다음 페이지 로드
  func loadMoreTodo() {
    guard hasNext, isLoadingNext == false else { return }

    isLoadingNext = true
    let nextPage = currentPage + 1

    service.fetchTodos(page: nextPage)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoadingNext = false
        if case .failure(let error) = completion {
          print("오류(loadMore): \(error)")
        }
      } receiveValue: { [weak self] response in
        guard let self else { return }
        // 페이지 기반이므로 중복은 없겠지만, 안전하게 중복 제거
        let existingIDs = Set(self.todos.map(\.id))
        let newItems = response.todos.filter { existingIDs.contains($0.id) == false }
        self.todos.append(contentsOf: newItems)

        self.hasNext = response.pagination.hasNext
        self.currentPage = response.pagination.currentPage
      }
      .store(in: &cancellables)
  }

}

