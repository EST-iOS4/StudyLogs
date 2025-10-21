//
//  Alert+ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 10/21/25.
//

import SwiftUI

extension Alert {
  struct ViewModel: Identifiable {
    let title: String
    let message: String
    let buttonText: String
    var id: String { title + message + buttonText }
  }
}
