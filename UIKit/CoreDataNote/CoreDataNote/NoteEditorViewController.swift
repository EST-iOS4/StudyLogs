//
//  NoteEditorViewController.swift
//  CoreDataNote
//
//  Created by Jungman Bae on 8/29/25.
//

import UIKit

class NoteEditorViewController: UIViewController {

  var note: Note?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = ((note != nil) ? note?.title ?? "" : "New Note")

    let saveAction = UIAction(title: "save", image: nil) { _ in
      self.save()
    }

    // 1. 셀렉터를 이용한 버튼 이벤트, @objc 함수 시그니처 호출
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(save)
    )

    // 2. UIAction 을 이용한 버튼 이벤트
    let cancelAction = UIAction(title: "", image: nil) { _ in
      self.dismiss(animated: true)
    }
    navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
  }

  @objc func save() {
// note 저장 후 닫기
    dismiss(animated: true)
  }

}
