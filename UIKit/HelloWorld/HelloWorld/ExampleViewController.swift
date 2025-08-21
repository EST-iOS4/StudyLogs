//
//  ExampleViewController.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/21/25.
//

import UIKit

class ExampleViewController: UIViewController {
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var backgroundImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    profileImageView.image = UIImage(named: "profile")

    profileImageView.contentMode = .scaleAspectFill

    profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    profileImageView.clipsToBounds = true

    profileImageView.layer.borderWidth = 3
    profileImageView.layer.borderColor = UIColor.blue.cgColor


  }
}
