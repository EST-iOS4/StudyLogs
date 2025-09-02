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
    searchBar.delegate = self
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

    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(itemAdded),
                   name: Notification.Name("itemAdded"),
                   object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: Notification.Name("itemAdded"),
                                              object: nil)
  }

  @objc func itemAdded(_ notification: Notification) {
    print("itemAdded called")
    loadNotes()
  }

  func setupUI() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    return notes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "Cell",
      for: indexPath
    )
    let note = notes[indexPath.row]

    var config = cell.defaultContentConfiguration()

    config.text = note.title

    if let modifiedDate = note.modifiedAt {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .none
      dateFormatter.timeStyle = .long
      config.secondaryText = dateFormatter.string(from: modifiedDate)
    }

    if let imageData =  note.imageData,
       let image: UIImage = UIImage(data:imageData){
      config.image = image
    }

    cell.contentConfiguration = config

    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let vc = NoteEditorViewController()
    vc.note = notes[indexPath.row]
    vc.view.backgroundColor = .systemBackground
    vc.modalPresentationStyle = .pageSheet
    present(UINavigationController(rootViewController: vc), animated: true)
  }
}


extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // (멤버변수 태스크) 아직 실행되지 않았다다면, invalidate => 작업 취소
    print(searchText)
    if !searchText.isEmpty {

      // Search Task 등록 (멤버변수 태스크) self.searchTask = Task
      // 0.2 초 후 실행되도록 스케줄링
      DispatchQueue.main.async {
        self.notes = self.noteManager.searchNotes(keyword: searchText)
        self.tableView.reloadData()
      }
    } else {
      loadNotes()
    }
  }
}
