import SwiftUI

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
  .autoconnect()

struct TimerView: View {
  @State private var currentTime = Date()

  private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter
  }()

  var body: some View {
    Text("현재 시각: \(currentTime, formatter: timeFormatter)")
  }
}

TimerView()
