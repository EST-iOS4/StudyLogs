//
//  ViewController.swift
//  StackViewAutoLayout
//
//  Created by Jungman Bae on 9/1/25.
//

import UIKit

class StackViewExampleViewController: UIViewController {
  @IBOutlet weak var mainStackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupStackView()
    createFormWithStackView()
  }

  func setupStackView() {
    // 스토리보드 Attributes Inspector 에서 동일하게 지정할 수 있음
    mainStackView.axis = .vertical
    mainStackView.distribution = .fill
    mainStackView.alignment = .fill
    mainStackView.spacing = 16

    //    view.addSubview(mainStackView) 스토리보드에서 이미 붙임

    NSLayoutConstraint.activate(
      [
        mainStackView.topAnchor
          .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        mainStackView.leadingAnchor
          .constraint(equalTo: view.leadingAnchor, constant: 20),
        mainStackView.trailingAnchor
          .constraint(equalTo: view.trailingAnchor, constant: -20),
        mainStackView.bottomAnchor
          .constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20
          )
      ]
    )
  }

  func createFormWithStackView() {
    let nameStackView = createInputStackView(label: "이름:", placeholder: "이름을 입력하세요")
    let emailStackView = createInputStackView(label: "이메일:", placeholder: "이메일을 입력하세요")

    [nameStackView, emailStackView].forEach {
      mainStackView.addArrangedSubview($0)
    }
  }

  func createInputStackView(label labelString: String, placeholder: String) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fill
    stackView.alignment = .center
    stackView.spacing = 8

    let label = UILabel()
    label.text = labelString
    label.widthAnchor.constraint(equalToConstant: 80).isActive = true

    let textField = UITextField()
    textField.placeholder = placeholder
    textField.borderStyle = .roundedRect

    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(textField)

    return stackView
  }
}

