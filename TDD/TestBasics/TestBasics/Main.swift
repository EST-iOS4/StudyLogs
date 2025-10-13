//
//  Main.swift
//  TestBasics
//
//  Created by Jungman Bae on 10/13/25.
//

import Foundation

func isLeap(_ year: Int) -> Bool {
  return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
}
