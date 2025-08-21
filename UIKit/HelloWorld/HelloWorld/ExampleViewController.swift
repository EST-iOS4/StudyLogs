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

  @IBOutlet weak var darkModeSwitch: UISwitch!
  @IBOutlet weak var volumeSlider: UISlider!
  @IBOutlet weak var volumeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    profileImageView.image = UIImage(named: "profile")

    profileImageView.contentMode = .scaleAspectFill

    profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    profileImageView.clipsToBounds = true

    profileImageView.layer.borderWidth = 3
    profileImageView.layer.borderColor = UIColor.blue.cgColor

    darkModeSwitch.isOn = false
    darkModeSwitch.onTintColor = .systemIndigo
    darkModeSwitch.addTarget(self, action: #selector(darkModeSwitchChanged), for: .valueChanged)

    volumeSlider.minimumValue = 0
    volumeSlider.maximumValue = 100
    volumeSlider.value = 50
    volumeSlider.minimumTrackTintColor = .systemBlue
    volumeSlider.maximumTrackTintColor = .lightGray

    volumeSlider.addTarget(self, action: #selector(volumeSliderChanged), for: .valueChanged)

  }

  @objc func darkModeSwitchChanged(_ sender: UISwitch) {
    if sender.isOn {
      overrideUserInterfaceStyle = .dark
      volumeLabel.textColor = .white
    } else {
      overrideUserInterfaceStyle = .light
      volumeLabel.textColor = .black
    }
  }

  @objc func volumeSliderChanged(_ sender: UISlider) {
    let volume = Int(sender.value)
    volumeLabel.text = "볼륨: \(volume)"
  }
}
