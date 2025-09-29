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

    setupBindings()

  }

  private func setupBindings() {
    viewModel.todosPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] todos in
        self?.updateDataSource(with: todos)
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

}

