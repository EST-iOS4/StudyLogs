//
//  ViewController.swift
//  SignupForm
//
//  Created by Jungman Bae on 8/22/25.
//

import UIKit

class ViewController: UIViewController {

  private let profileImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
    imageView.frame = CGRect(x: 150, y: 200, width: 100, height: 100)
    return imageView
  }()

  private let emailTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "이메일을 입력하세요"
    textField.borderStyle = .roundedRect
    textField.keyboardType = .emailAddress
    textField.returnKeyType = .next
    textField.frame = CGRect(x: 50, y: 350, width: 300, height: 40)
    return textField
  }()

  private let submitButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("가입하기", for: .normal)
    button.frame = CGRect(x: 150, y: 400, width: 100, height: 40)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    title = "SignupForm"
    view.backgroundColor = .systemBackground

    setupUI()
  }

  func setupUI() {
    view.addSubview(profileImageView)
    view.addSubview(emailTextField)
    view.addSubview(submitButton)

    submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
  }

  @objc func submitButtonTapped() {
    guard let email = emailTextField.text, !email.isEmpty else {
      print("이메일을 입력해주세요.")
      return
    }
    print("가입 요청: 이메일 = \(email)")
  }
}

