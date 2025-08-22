//
//  ViewController.swift
//  TableView
//
//  Created by Jungman Bae on 8/22/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

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
    return 20 // 예시로 20개의 행을 표시
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
    cell.configure(with: "행 \(indexPath.row + 1)")
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
