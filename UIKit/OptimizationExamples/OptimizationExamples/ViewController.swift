//
//  ViewController.swift
//  OptimizationExamples
//
//  Created by Jungman Bae on 9/2/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension

    tableView.prefetchDataSource = self

    tableView.register(ComplexTableViewCell.self, forCellReuseIdentifier: "ComplexCell")
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1000
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "ComplexCell",
      for: indexPath
    ) as! ComplexTableViewCell
    return cell
  }

}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

  }
}

// 🎨 ComplexTableViewCell - 재사용 가능한 셀
class ComplexTableViewCell: UITableViewCell {
  var imageLoadTask: URLSessionDataTask?

  // 🔄 셀 재사용 준비 (중요!)
  override func prepareForReuse() {
    super.prepareForReuse()

    // 🖼️ 이미지 초기화
    imageView?.image = nil

    // 🚫 진행 중인 작업 취소
    imageLoadTask?.cancel()
    imageLoadTask = nil

    print("♻️ 셀 재사용 준비 완료")
  }
}
