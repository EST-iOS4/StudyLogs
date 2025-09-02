//
//  ViewController.swift
//  OptimizationExamples
//
//  Created by Jungman Bae on 9/2/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  private let cellHeightCache = NSCache<NSNumber, NSNumber>()

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

    configureCell(cell, at: indexPath)

    return cell
  }

  // ⚙️ 셀 설정 함수 (효율적으로!)
  private func configureCell(_ cell: ComplexTableViewCell, at indexPath: IndexPath) {
    // 📝 빠른 텍스트 설정 (동기)
    cell.textLabel?.text = "아이템 \(indexPath.row)"

    // 🖼️ 이미지 로드 (비동기 - UI 끊김 방지)
    let imageURL = URL(string: "https://picsum.photos/200/300")!

    cell.imageLoadTask = URLSession.shared.dataTask(with: URLRequest(url: imageURL)) { [weak self, weak cell] data, response, error in
      DispatchQueue.main.async {
        if let currentIndexPath = self?.tableView.indexPath(for: cell!),
           currentIndexPath == indexPath {
          if let imageData = data {
            cell?.imageView?.image = UIImage(data: imageData)
          } else {
            cell?.imageView?.image = UIImage(systemName: "photo")
          }
          cell?.layoutIfNeeded()
        }
      }
    }
    cell.imageLoadTask?.resume()

    // 📏 높이 계산 캐싱 (반복 계산 방지)
    if let cachedHeight = cellHeightCache.object(forKey: indexPath.row as NSNumber) {
      cell.heightConstraint?.constant = CGFloat(truncating: cachedHeight)
    } else {
      let height = calculateHeight(for: indexPath)
      cellHeightCache.setObject(NSNumber(value: Double(height)), forKey: indexPath.row as NSNumber)
      cell.heightConstraint?.constant = height
    }

  }

  // 🧮 높이 계산 함수 (복잡한 계산은 캐싱!)
  private func calculateHeight(for indexPath: IndexPath) -> CGFloat {
    // 복잡한 높이 계산 로직
    return CGFloat(100 + (indexPath.row % 3) * 50)
  }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    print("🔮 미리 로딩할 셀들: \(indexPaths.map { $0.row })")

    // 이미지 미리 다운로드
//    for indexPath in indexPaths {
//      let imageURL = URL(string: "https://example.com/image\(indexPath.row).jpg")!
//      ImageCache.shared.preloadImage(from: imageURL)
//    }
  }
}

// 🎨 ComplexTableViewCell - 재사용 가능한 셀
class ComplexTableViewCell: UITableViewCell {
  var imageLoadTask: URLSessionDataTask?
  var heightConstraint: NSLayoutConstraint?

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
