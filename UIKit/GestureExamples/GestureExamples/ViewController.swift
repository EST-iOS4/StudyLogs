//
//  ViewController.swift
//  GestureExamples
//
//  Created by Jungman Bae on 9/2/25.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var doubleTapLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    setupTapGestures()
  }

  func setupTapGestures() {
    // 👆 싱글 탭 제스처 (한 번 탭)
    let singleTap = UITapGestureRecognizer(
      target: self,
      action: #selector(handleSingleTap)
    )
    singleTap.numberOfTapsRequired = 1        // 1번 탭으로 인식
    singleTap.numberOfTouchesRequired = 1     // 손가락 1개 필요
    imageView.addGestureRecognizer(singleTap)

    // 👆👆 더블 탭 제스처 (두 번 연속 탭)
    let doubleTap = UITapGestureRecognizer(
      target: self,
      action: #selector(handleDoubleTap(_:))
    )
    doubleTap.numberOfTapsRequired = 2        // 2번 탭으로 인식
    doubleTap.numberOfTouchesRequired = 1     // 손가락 1개 필요
    imageView.addGestureRecognizer(doubleTap)

    // 🎯 중요: 더블 탭이 실패해야 싱글 탭 인식
    // (더블 탭을 기다렸다가 실패하면 싱글 탭으로 처리)
    singleTap.require(toFail: doubleTap)

//    // 두 손가락 탭
    let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(handleTwoFingerTap))
    twoFingerTap.numberOfTouchesRequired = 2
    view.addGestureRecognizer(twoFingerTap)

    // 🎯 이미지뷰가 터치를 받을 수 있게 설정
    imageView.isUserInteractionEnabled = true

  }

  // 👆 싱글 탭 처리
  @objc func handleSingleTap(_ gesture: UITapGestureRecognizer) {
    print("✨ 싱글 탭 감지됨!")

    // 📍 탭한 위치 확인
    let location = gesture.location(in: imageView)
    print("탭 위치: \(location)")

//    // 🎊 리플 효과 표시
    showRippleEffect(at: location)

    // 📝 상태 레이블 업데이트
    doubleTapLabel.text = "싱글 탭! 위치: (\(Int(location.x)), \(Int(location.y)))"

    // 📳 햅틱 피드백
    let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    impactFeedback.impactOccurred()
  }

  // 👆👆 더블 탭 처리
  @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
    print("🔍 더블 탭 감지됨!")

    // 🔍 확대/축소 토글 (Instagram 스타일)
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 0.1,
      options: .curveEaseInOut,
      animations: {
        if self.imageView.transform == .identity {
          // 🔍 2배 확대
          self.imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
          self.doubleTapLabel.text = "🔍 2배 확대됨!"
        } else {
          // 🔄 원래 크기로 복원
          self.imageView.transform = .identity
          self.doubleTapLabel.text = "🔄 원래 크기로 복원!"
        }
      },
      completion: nil
    )

    // 📳 강한 햅틱 피드백
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    impactFeedback.impactOccurred()
  }

  // 👥 두 손가락 탭 처리
  @objc func handleTwoFingerTap(_ gesture: UITapGestureRecognizer) {
    print("👥 두 손가락 탭 감지됨!")

    // 🎨 랜덤 배경색 변경
    let colors: [UIColor] = [
      .systemBlue, .systemPurple, .systemGreen,
        .systemOrange, .systemPink, .systemTeal
    ]

    UIView.animate(withDuration: 0.5) {
      self.view.backgroundColor = colors.randomElement()
    }

    doubleTapLabel.text = "🎨 배경색이 변경되었어요!"

    // 📳 성공 햅틱 피드백
    let notificationFeedback = UINotificationFeedbackGenerator()
    notificationFeedback.notificationOccurred(.success)
  }

  // 🎊 리플 효과 애니메이션
  func showRippleEffect(at point: CGPoint) {
    // 🎊 리플 뷰 생성
    let rippleView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    rippleView.center = point
    rippleView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
    rippleView.layer.cornerRadius = 20
    imageView.addSubview(rippleView)

    // ✨ 확산 애니메이션
    UIView.animate(
      withDuration: 0.6,
      delay: 0,
      options: .curveEaseOut,
      animations: {
        rippleView.transform = CGAffineTransform(scaleX: 4, y: 4)
        rippleView.alpha = 0
      },
      completion: { _ in
        rippleView.removeFromSuperview()
      }
    )
  }

}

