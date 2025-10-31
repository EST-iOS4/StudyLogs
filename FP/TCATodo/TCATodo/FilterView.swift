//
//  FilterView.swift
//  TCATodo
//
//  Created by Jungman Bae on 10/31/25.
//

import SwiftUI

struct FilterView: View {
  @Binding var viewModel: TodoView.ViewModel

  @State private var selectedFilter: TodoState.Filter = .all

  var body: some View {
    Picker("Filter", selection: $selectedFilter) {
      ForEach(TodoState.Filter.allCases, id: \.self) { filter in
        Text(filter.rawValue).tag(filter)
      }
    }
    .pickerStyle(SegmentedPickerStyle())
    .padding(.horizontal)
  }
}
