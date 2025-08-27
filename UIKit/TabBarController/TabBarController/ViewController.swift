//
//  ViewController.swift
//  TabBarController
//
//  Created by Jungman Bae on 8/27/25.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    title = "홈"
    view.backgroundColor = .systemBackground

    let label = UILabel(
      frame: CGRect(x: (view.frame.width - 100) / 2, y: 150, width: 100, height: 50)
    )
    label.text = "홈 화면"
    label.font = UIFont.systemFont(ofSize: 30)
    view.addSubview(label)
  }


}

