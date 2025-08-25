//
//  ViewController.swift
//  TodoList
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  var todos: [TodoItem] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self

    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTodo)
    )
  }

  @objc func addTodo() {
    let alert = UIAlertController(
      title: "새 할 일",
      message: nil,
      preferredStyle: .alert
    )

    alert.addTextField { textField in
      textField.placeholder = "할 일을 입력하세요"
    }

    let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
      guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
      let newTodo = TodoItem(title: text, isCompleted: false, priority: .medium)
      // 데이터 업데이트
      self.todos.append(newTodo)
      // 뷰 업데이트
      let indexPath = IndexPath(row: self.todos.count - 1, section: 0)
      self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    alert.addAction(saveAction)
    present(alert, animated: true)
  }
}


extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "TodoCell",
      for: indexPath
    ) as! TodoTableViewCell

    cell.configure(with: todos[indexPath.row])

    cell.onToggleComplete = {
      self.todos[indexPath.row].isCompleted.toggle()
      self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    return cell
  }
}
