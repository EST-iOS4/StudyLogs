//
//  ViewController.swift
//  TableView
//
//  Created by Jungman Bae on 8/22/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  var items = ["Apple #1", "Banana #2", "Cherry #3", "Date #4",
               "Elderberry #5", "Fig #6", "Grape #7", "Honeydew #8"]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .plain,
                                                        target: self, action: #selector(editButtonTapped))
  }

  @objc func editButtonTapped() {
    tableView.isEditing.toggle()
    navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "완료" : "편집"
  }
}

extension ViewController: UITableViewDataSource {
  // DataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(
    _ tableView: UITableView,
    moveRowAt sourceIndexPath: IndexPath,
    to destinationIndexPath: IndexPath
  ) {
    let moveItem = items.remove(at: sourceIndexPath.row)
    items.insert(moveItem, at: destinationIndexPath.row)
  }

  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      items.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    cell.configure(with: items[indexPath.row])
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  // Delegate
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let alert = UIAlertController(title: "선택됨", message: "행 \(indexPath.row + 1)을 선택했습니다.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    present(alert, animated: true)
  }

}
