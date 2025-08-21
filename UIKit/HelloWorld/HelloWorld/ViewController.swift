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
  }

  @IBAction func sayHelloButtonTapped(_ sender: Any) {
    let name = nameTextField.text ?? ""
    if name.isEmpty {
      greetingLabel.text = "이름을 입력해주세요."
    } else {
      greetingLabel.text = "안녕하세요, \(name)님!"
    }
  }

}
