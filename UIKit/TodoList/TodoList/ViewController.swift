//
//  ViewController.swift
//  TodoList
//
//  Created by Jungman Bae on 8/25/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  var todos: [TodoItem] = [
    TodoItem(title: "test1", isCompleted: false, priority: .low),
    TodoItem(title: "test2", isCompleted: false, priority: .medium),
    TodoItem(title: "test3", isCompleted: false, priority: .high)
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self

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
