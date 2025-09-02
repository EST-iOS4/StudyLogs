//
//  ViewController.swift
//  OptimizationExamples
//
//  Created by Jungman Bae on 9/2/25.
//

import UIKit

class Person {
  let name: String
  weak var apartment: Apartment?  // Person이 Apartment를 참조

  init(name: String) {
    self.name = name
    print("👤 \(name)이 생성되었습니다")
  }

  deinit {
    print("👤 \(name)이 메모리에서 해제되었습니다")
  }
}

class Apartment {
  let unit: String
  var tenant: Person?  // Apartment가 Person을 참조

  init(unit: String) {
    self.unit = unit
    print("🏠 아파트 \(unit)가 생성되었습니다")
  }

  deinit {
    print("🏠 아파트 \(unit)가 메모리에서 해제되었습니다")
  }
}

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    print("2초후에 실행됩니다.")

    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
//      var john: Person? = Person(name: "John")  // Person 참조 카운트: 1
//      var unit4A: Apartment? = Apartment(unit: "4A")  // Apartment 참조 카운트: 1
//
//      john?.apartment = unit4A  // Apartment 참조 카운트: 2
//      unit4A?.tenant = john     // Person 참조 카운트: 2
//
//      // ❌ john과 unit4A를 nil로 설정해도 deinit이 호출되지 않음!
//      john = nil    // Person 참조 카운트: 1 (여전히 apartment가 참조 중)
//      unit4A = nil  // Apartment 참조 카운트: 1 (여전히 tenant가 참조 중)
//
//      print("실행 완료")

      let vc = MemoryTestViewController()
      self?.present(vc, animated: true)
    }

  }


}

