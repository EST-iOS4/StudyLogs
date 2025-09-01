//
//  ViewController.swift
//  NewsReader
//
//  Created by Jungman Bae on 9/1/25.
//

import UIKit

class ViewController: UIViewController {

  lazy var tableView: UITableView =  {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self

    NSLayoutConstraint.activate([
      tableView.topAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    return tableView
  }()

  lazy var activityIndicator = UIActivityIndicatorView()

  let newsService = NewsAPIService()
  let refreshControl = UIRefreshControl()

  var articles: [Article] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "News Reader"
    view.backgroundColor = .systemBackground
    setupUI()
    loadNews()
  }

  func setupUI() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.refreshControl = refreshControl
    refreshControl.addTarget(self,
                             action: #selector(refreshNews),
                             for: .valueChanged)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(activityIndicator)

    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  func loadNews() {
    activityIndicator.startAnimating()

    newsService.fetchTopHeadlines { [weak self] result in
      print("fetchTopHeadlines: \(result)")
      self?.activityIndicator.stopAnimating()
      self?.refreshControl.endRefreshing()
      switch result {
      case .success(let articles):
        self?.articles = articles
        self?.tableView.reloadData()
      case .failure(let error):
        self?.showError(error)
      }
    }
  }

  @objc func refreshNews() {
    loadNews()
  }

  func showError(_ error: Error) {
    let alert = UIAlertController(
      title: "에러",
      message: error.localizedDescription,
      preferredStyle: .alert
    )

    alert.addAction(UIAlertAction(title: "재시도", style: .default) { _ in
      self.loadNews()
    })

    alert.addAction(UIAlertAction(title: "확인", style: .cancel))

    present(alert, animated: true)

  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "Cell",
      for: indexPath
    )
    let article = articles[indexPath.row]
    var config = cell.defaultContentConfiguration()
    config.text = article.title

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    config.secondaryText = dateFormatter.string(from: article.publishedAt)

    if let urlString = article.urlToImage,
       let url = URL(string: urlString) {
      let session = URLSession.shared
      session.dataTask(with: URLRequest(url: url)) { data, response, error in

        if let imageData = data {
          config.image = UIImage(data: imageData)
        }
      }
    } else {
      config.image = UIImage(systemName: "photo")
    }

    cell.contentConfiguration = config

    return cell
  }


}

extension ViewController: UITableViewDelegate {

}



