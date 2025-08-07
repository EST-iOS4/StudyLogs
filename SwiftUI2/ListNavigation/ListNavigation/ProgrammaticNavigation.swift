//
//  ProgrammaticNavigation.swift
//  ListNavigation
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct ProgrammaticNavigation: View {
  
  var body: some View {
    NavigationStack {
      List {
        NavigationLink("상세 화면으로", destination: DetailView())
      }
      .navigationTitle("내 사람들")
    }
  }
}

struct DetailView: View {
  var body: some View {
    Text("상세화면")
      .font(.largeTitle)
      .padding()
  }
}

#Preview {
  ProgrammaticNavigation()
}
