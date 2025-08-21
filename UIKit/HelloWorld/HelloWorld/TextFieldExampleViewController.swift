//
//  TextFieldExampleViewController.swift
//  HelloWorld
//
//  Created by Jungman Bae on 8/21/25.
//

import UIKit

class TextFieldExampleViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    emailTextField.placeholder = "이메일을 입력하세요"
    passwordTextField.placeholder = "비밀번호를 입력하세요"

    emailTextField.keyboardType = .emailAddress
    passwordTextField.isSecureTextEntry = true

    emailTextField.returnKeyType = .next
    passwordTextField.returnKeyType = .done

    emailTextField.delegate = self
    passwordTextField.delegate = self

    emailTextField.borderStyle = .roundedRect

    let emailIcon = UIImageView(image: UIImage(systemName: "envelope"))
    emailIcon.tintColor = .gray
    emailTextField.leftView = emailIcon
    emailTextField.leftViewMode = .always
  }
}

extension TextFieldExampleViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
      textField.resignFirstResponder()
    }
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    print("현재 텍스트: \(textField.text ?? "")")
    print("입력 중: \(string)")
    print("-------------")
    if textField == emailTextField {
      let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
      validateEmail(updatedText)
    }
    return true
  }

  @MainActor
  func validateEmail(_ email: String) {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    let isValid = emailPredicate.evaluate(with: email)

    emailTextField.rightView = UIImageView(image: UIImage(systemName: isValid ? "checkmark.circle" : "xmark.circle"))
    emailTextField.rightView?.tintColor = isValid ? .green : .red
    emailTextField.rightViewMode = email.isEmpty ? .never : .always

    if isValid {
      print("유효한 이메일 형식입니다.")
    } else {
      print("유효하지 않은 이메일 형식입니다.")
    }
  }
}
