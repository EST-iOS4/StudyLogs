//
//  ContentView.swift
//  Weather
//
//  Created by Jungman Bae on 9/22/25.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    WeatherView()
}
