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
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save)
    navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel)
  }
  
}
