//
//  ViewController.swift
//  TableView
//
//  Created by Jungman Bae on 8/22/25.
//

import UIKit

class ViewController: UIViewController {
  let tableView: UITableView = {
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
    return tableView
  }()

  var fruits:[String: [String]] = [:]
  var sectionTitles: [String] = []

  // 검색
  let searchController = UISearchController(searchResultsController: nil)

  var filteredItems: [String] = []
  var isSearching: Bool {
    return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)

    title = "TableView Example"

    tableView.delegate = self
    tableView.dataSource = self

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .plain,
                                                        target: self, action: #selector(editButtonTapped))

    setupData()
    setupSearchController()
    setupRefreshControl()
  }

  func setupData() {
    // 데이터 초기화
    fruits = [
      "A": ["Apple #1", "Apricot \(Date())"],
      "B": ["Banana #2 \(Date())", "Blueberry"],
      "C": ["Cherry #3", "Clementine"],
      "D": ["Date #4", "Dragonfruit"],
      "E": ["Elderberry #5", "Eggplant"],
      "F": ["Fig #6", "Feijoa"],
      "G": ["Grape #7", "Guava"],
      "H": ["Honeydew #8", "Huckleberry"]
    ]

    sectionTitles = fruits.keys.sorted()
  }

  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "과일 검색"
    navigationItem.searchController = searchController
    definesPresentationContext = true

    // 검색바의 스타일 설정
    searchController.searchBar.barStyle = .default
    searchController.searchBar.tintColor = .systemBlue
  }

  func setupRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "새로고침 중...")
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  @objc func editButtonTapped() {
    tableView.isEditing.toggle()
    navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "완료" : "편집"
  }

  @objc func refreshData() {
    // 데이터 새로고침 로직 (비동기 함수 호출)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.setupData()
      self.tableView.reloadData()
      self.tableView.refreshControl?.endRefreshing()
    }
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return isSearching ? 1 : sectionTitles.count
  }

  // 데이터 섹션 행 아이템의 개수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionTitle = sectionTitles[section]
    return isSearching ? filteredItems.count : (fruits[sectionTitle]?.count ?? 0)
  }

  // 셀 단위의 편집 기능 활성화 여부
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return isSearching ? false : true
  }

  // 셀을 이동할 수 있는지 여부
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return isSearching ? false : true
  }

  // 셀을 이동할 때 호출되는 메서드
  func tableView(
    _ tableView: UITableView,
    moveRowAt sourceIndexPath: IndexPath, // 이동할 셀의 현재 위치
    to destinationIndexPath: IndexPath // 이동할 셀의 새로운 위치
  ) {
    let sectionTitle = sectionTitles[sourceIndexPath.section]
    guard var items = fruits[sectionTitle] else { return }

    // 이동할 아이템을 제거하고 새로운 위치에 삽입
    let item = items.remove(at: sourceIndexPath.row)
    items.insert(item, at: destinationIndexPath.row)

    // 섹션의 아이템을 업데이트
    fruits[sectionTitle] = items
  }

  // 셀을 삭제할 때 호출되는 메서드
  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      let sectionTitle = sectionTitles[indexPath.section]
      guard var items = fruits[sectionTitle] else { return }

      // 해당 아이템을 삭제
      items.remove(at: indexPath.row)

      // 섹션의 아이템을 업데이트
      if items.isEmpty {
        fruits.removeValue(forKey: sectionTitle)
        sectionTitles.remove(at: indexPath.section)
        tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
      } else {
        fruits[sectionTitle] = items
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  }

  // 섹션 헤더 타이틀
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return isSearching ? "검색 결과" : sectionTitles[section]
  }

  // 셀을 구성하는 메서드
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    if isSearching {
      cell.textLabel?.text = filteredItems[indexPath.row]
      return cell
    }

    let sectionTitle = sectionTitles[indexPath.section]
    if let items = fruits[sectionTitle] {
      cell.textLabel?.text = items[indexPath.row]
    } else {
      cell.textLabel?.text = "데이터 없음"
    }
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
      let sectionTitle = self.sectionTitles[indexPath.section]
      guard var items = self.fruits[sectionTitle] else { return }
      // 해당 아이템을 삭제
      items.remove(at: indexPath.row)
      // 섹션의 아이템을 업데이트
      if items.isEmpty {
        self.fruits.removeValue(forKey: sectionTitle)
        self.sectionTitles.remove(at: indexPath.section)
        tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
      } else {
        self.fruits[sectionTitle] = items
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
      completionHandler(true)
    }

    return UISwipeActionsConfiguration(actions: [deleteAction])
  }
}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
      filteredItems.removeAll()
      tableView.reloadData()
      return
    }
    filterContentForSearchText(searchText)
  }

  func filterContentForSearchText(_ searchText: String) {
    filteredItems = sectionTitles.flatMap { sectionTitle in
      fruits[sectionTitle]?.filter { $0.localizedCaseInsensitiveContains(searchText) } ?? []
    }
    tableView.reloadData()
  }
}

#Preview {
  UINavigationController(rootViewController: ViewController())
}
