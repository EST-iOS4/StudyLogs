//
//  ViewController.swift
//  TableView
//
//  Created by Jungman Bae on 8/22/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  let items = ["Apple #1", "Banana #2", "Cherry #3", "Date #4",
               "Elderberry #5", "Fig #6", "Grape #7", "Honeydew #8"]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    tableView.register(CustomCell.self, forCellReuseIdentifier: "Cell")
  }
}

extension ViewController: UITableViewDataSource {
  // DataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
    cell.configure(with: items[indexPath.row])
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
