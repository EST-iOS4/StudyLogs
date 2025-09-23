//
//  DataListView.swift
//  ErrorExample
//
//  Created by Jungman Bae on 9/23/25.
//

import SwiftUI

struct DataListView: View {
  let data: [String]
  
  var body: some View {
    List(data, id: \.self) { Text($0) }
  }
}
