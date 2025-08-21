//
//  ViewController.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/21/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var greetingLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    greetingLabel.text = "UIKit에 오신 것을 환영합니다!"

    let customButton = UIButton(type: .system)
    customButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
    customButton.setTitle("커스텀 버튼", for: .normal)
    customButton.setTitleColor(.white, for: .normal)
    customButton.backgroundColor = .systemBlue
    customButton.layer.cornerRadius = 10

    customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    view.addSubview(customButton)

    let imageButton = UIButton(type: .custom)
    imageButton.frame = CGRect(x: 100, y: 150, width: 100, height: 100)
    imageButton.setImage(UIImage(systemName: "heart"), for: .normal)
    imageButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    imageButton.tintColor = .systemRed
    imageButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)

    view.addSubview(imageButton)
  }

  @IBAction func sayHelloButtonTapped(_ sender: Any) {
    let name = nameTextField.text ?? ""
    if name.isEmpty {
      greetingLabel.text = "이름을 입력해주세요."
    } else {
      greetingLabel.text = "안녕하세요, \(name)님!"
    }
  }

  @objc func buttonTapped(_ sender: UIButton) {
    print("버튼이 탭 되었습니다.")
    UIView.animate(withDuration: 0.1) {
      sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    } completion: { _ in
      UIView.animate(withDuration: 0.1) {
        sender.transform = .identity
      }
    }
  }

  @objc func heartButtonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender.isSelected {
      print("하트가 선택되었습니다.")
    } else {
      print("하트가 선택 해제되었습니다.")
    }
  }
}
