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

    loadNotes()
  }

  func loadNotes() {
    notes = noteManager.searchNotes(keyword: searchBar.text ?? "")
    tableView.reloadData()
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
