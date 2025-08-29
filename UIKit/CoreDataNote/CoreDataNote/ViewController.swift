//
//  ViewController.swift
//  CoreDataNote
//
//  Created by Jungman Bae on 8/29/25.
//

import UIKit

class ViewController: UIViewController {
  let noteManager = NoteManager()
  var notes: [Note] = []

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor
        .constraint(equalTo: self.searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])

    return tableView
  }()

  lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(searchBar)

    NSLayoutConstraint.activate([
      searchBar.topAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    return searchBar
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    tableView.dataSource = self
    tableView.delegate = self

    setupUI()
    loadNotes()
  }

  func setupUI() {
    tableView.tableHeaderView = UIView()
    tableView.tableHeaderView?.frame = CGRect(
      x: 0,
      y: 0,
      width: view.frame.width,
      height: 50
    )
    tableView.tableHeaderView?.backgroundColor = .systemBackground

    var config = UIButton.Configuration.filled()
    config.title = "노트추가"
    let button = UIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false

    button.addTarget(self, action: #selector(addNote), for: .touchUpInside)

    tableView.tableHeaderView?.addSubview(button)

    NSLayoutConstraint.activate([
      button.centerXAnchor
        .constraint(equalTo: tableView.tableHeaderView!.centerXAnchor),
      button.centerYAnchor
        .constraint(equalTo: tableView.tableHeaderView!.centerYAnchor)
    ])
  }

  func loadNotes() {
    notes = noteManager.searchNotes(keyword: searchBar.text ?? "")
    tableView.reloadData()
  }

  @objc func addNote() {
    print("click")
    let vc = NoteEditorViewController()
    vc.view.backgroundColor = .systemBackground
    vc.modalPresentationStyle = .pageSheet
    present(UINavigationController(rootViewController: vc), animated: true)
  }
}


extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

extension ViewController: UITableViewDelegate {

}
