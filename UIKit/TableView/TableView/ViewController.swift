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
  // 데이터 아이템의 개수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  // 셀 단위의 편집 기능 활성화 여부
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  // 셀을 이동할 수 있는지 여부
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  // 셀을 이동할 때 호출되는 메서드
  func tableView(
    _ tableView: UITableView,
    moveRowAt sourceIndexPath: IndexPath, // 이동할 셀의 현재 위치
    to destinationIndexPath: IndexPath // 이동할 셀의 새로운 위치
  ) {
    let moveItem = items.remove(at: sourceIndexPath.row)
    items.insert(moveItem, at: destinationIndexPath.row)
  }

  // 셀을 삭제할 때 호출되는 메서드
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

  // 셀을 구성하는 메서드
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    cell.configure(with: items[indexPath.row])
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  // 셀이 선택될 때 호출되는 메서드
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let alert = UIAlertController(title: "선택됨", message: "행 \(indexPath.row + 1)을 선택했습니다.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    present(alert, animated: true)
  }

  // 커스텀 스와이프 액션
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { _, _, completionHandler in
      self.items.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
      completionHandler(true)
    }

    let favoriteAction = UIContextualAction(style: .normal, title: "즐겨찾기") { _, _, completionHandler in
      let item = self.items[indexPath.row]
      print("\(item)이(가) 즐겨찾기에 추가되었습니다.")
      completionHandler(true)
    }

    return UISwipeActionsConfiguration(actions: [deleteAction, favoriteAction])
  }

  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let favoriteAction = UIContextualAction(style: .normal, title: "즐겨찾기") { _, _, completionHandler in
      let item = self.items[indexPath.row]
      print("\(item)이(가) 즐겨찾기에 추가되었습니다.")
      completionHandler(true)
    }
    return UISwipeActionsConfiguration(actions: [favoriteAction])

  }

}
