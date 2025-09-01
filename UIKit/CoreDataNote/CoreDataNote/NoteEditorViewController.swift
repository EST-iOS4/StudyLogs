//
//  NoteEditorViewController.swift
//  CoreDataNote
//
//  Created by Jungman Bae on 8/29/25.
//

import UIKit

class NoteEditorViewController: UIViewController {

  let noteManager = NoteManager()
  var note: Note?

  let titleText = UITextField()
  let contentText = UITextView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
    title = ((note != nil) ? note?.title ?? "" : "New Note")

    // 1. 셀렉터를 이용한 버튼 이벤트, @objc 함수 시그니처 호출
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(save)
    )

    // 2. UIAction 을 이용한 버튼 이벤트
    let cancelAction = UIAction { _ in
      self.dismiss(animated: true)
    }
    navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel,
                                                       primaryAction: cancelAction)

    titleText.translatesAutoresizingMaskIntoConstraints = false
    titleText.placeholder = "제목"
    titleText.borderStyle = .roundedRect
    view.addSubview(titleText)

    contentText.translatesAutoresizingMaskIntoConstraints = false
    contentText.backgroundColor = .systemGray
    view.addSubview(contentText)

    NSLayoutConstraint.activate([
      // titleText
      titleText.topAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
      titleText.leadingAnchor
        .constraint(equalTo: view.leadingAnchor, constant: 20),
      titleText.trailingAnchor
        .constraint(equalTo: view.trailingAnchor, constant: -20),

      // contentText
      contentText.topAnchor
        .constraint(equalTo: titleText.bottomAnchor, constant: 20),
      contentText.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
      contentText.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
      contentText.heightAnchor.constraint(equalToConstant: 300)

    ])
  }

  @objc func save() {
    if let title = titleText.text,
       let content = contentText.text {
      _ = noteManager
        .createNote(title: title, content: content, image: nil)      
    } else {
      // TODO: Alert 오류 표시
    }
    dismiss(animated: true) {
      print("dismiss completion")
    }
  }

}
