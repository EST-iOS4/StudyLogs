//
//  ViewController.swift
//  DiffableTodo
//
//  Created by Jungman Bae on 9/29/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  private let viewModel = TodoViewModel()
  private var cancellables = Set<AnyCancellable>()
  // "더보기" 아이템은 동일 인스턴스를 재사용해 ID가 안정적으로 유지되도록 함
  private let loadMoreItem = TodoItem(title: "더보기")

  private lazy var dataSource: UITableViewDiffableDataSource<Section, TodoItem> = {
    UITableViewDiffableDataSource(tableView: tableView) {
      @MainActor tableView, indexPath, item in
      let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
      cell.accessoryType = item.isCompleted ? .checkmark : .none

      var config = cell.defaultContentConfiguration()
      config.text = item.title
      config.textProperties.color = item.isCompleted ? .gray : .label
      cell.contentConfiguration = config

      return cell
    }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Diffable Todo"

    // Ensure delegate is set to receive selection events
    tableView.delegate = self

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      systemItem: .add,
      primaryAction: UIAction {
        [weak self] _ in
        let alert = UIAlertController(
          title: "새 할 일",
          message: nil,
          preferredStyle: .alert
        )

        alert.addTextField { textField in
          textField.placeholder = "할 일을 입력하세요."
        }

        let addAction = UIAlertAction(title: "추가", style: .default) {
          [weak self] _ in
          guard let self,
                let text = alert.textFields?.first?.text,
                !text.isEmpty
          else { return }
          self.viewModel.addTodo(text)
        }

        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self?.present(alert, animated: true)
      })


    setupBindings()
  }

  private func setupBindings() {
    viewModel.$todos
      .receive(on: DispatchQueue.main)
      .sink { [weak self] todos in
        self?.updateDataSource(with: todos)
      }
      .store(in: &cancellables)

    viewModel.$hasNext
      .receive(on: DispatchQueue.main)
      .sink { [weak self] hasNext in
        print("hasNext: \(hasNext)")
        self?.updateHasNext(with: hasNext)
      }
      .store(in: &cancellables)

  }

  private func updateDataSource(with todos: [TodoItem]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, TodoItem>()

    let incompletedTodos = todos.filter { $0.isCompleted == false }
    let completedTodos = todos.filter { $0.isCompleted == true }

    if incompletedTodos.isEmpty == false {
      snapshot.appendSections([.todo])
      snapshot.appendItems(incompletedTodos, toSection: .todo)
    }

    if completedTodos.isEmpty == false {
      snapshot.appendSections([.completed])
      snapshot.appendItems(completedTodos, toSection: .completed)
    }

    dataSource.apply(snapshot, animatingDifferences: true)
  }


  private func updateHasNext(with hasNext: Bool) {
    // 기존 스냅샷을 가져와 마지막에 .next 섹션을 반영
    var snapshot = dataSource.snapshot()

    // 기존의 .next 섹션이 있다면 제거
    if snapshot.sectionIdentifiers.contains(.next) {
      snapshot.deleteSections([.next])
    }

    // hasNext가 true이면 .next 섹션을 마지막에 추가하고 "더보기" 아이템을 넣음
    if hasNext {
      snapshot.appendSections([.next])
      snapshot.appendItems([loadMoreItem], toSection: .next)
    }

    dataSource.apply(snapshot, animatingDifferences: true)
  }

}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    // .next 섹션은 선택 동작을 무시
    let sectionIDs = dataSource.snapshot().sectionIdentifiers
    if indexPath.section < sectionIDs.count, sectionIDs[indexPath.section] == .next {
      return
    }

    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    viewModel.toggleTodo(id: item.id)
  }

  // .next 섹션 셀이 화면에 보이면 다음 페이지 로드
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let sectionIDs = dataSource.snapshot().sectionIdentifiers
    guard indexPath.section < sectionIDs.count, sectionIDs[indexPath.section] == .next else { return }
    guard viewModel.hasNext, !viewModel.isLoadingNext else { return }

    viewModel.loadMoreTodo()
  }
}

