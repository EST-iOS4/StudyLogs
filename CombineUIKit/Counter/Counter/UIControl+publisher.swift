//
//  UIControl+publisher.swift
//  Counter
//
//  Created by Jungman Bae on 9/29/25.
//

import UIKit
import Combine

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription
where SubscriberType.Input == Control, SubscriberType.Failure == Never
{
  private var subscriber: SubscriberType?
  private weak var control: Control?
  private let event: UIControl.Event

  init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
    self.subscriber = subscriber
    self.control = control
    self.event = event
    control.addTarget(self, action: #selector(eventHandler), for: event)
  }

  func request(_ demand: Subscribers.Demand) {
    // 여기선 demand 무시해도 돼 (간단한 경우)
  }

  func cancel() {
    subscriber = nil
  }

  @objc private func eventHandler() {
    guard let control = control else { return }
    _ = subscriber?.receive(control)
  }
}

struct UIControlPublisher<Control: UIControl>: Publisher {
  typealias Output = Control
  typealias Failure = Never

  private weak var control: Control?
  private let events: UIControl.Event

  init(control: Control, events: UIControl.Event) {
    self.control = control
    self.events = events
  }

  func receive<S>(subscriber: S) where S : Subscriber, S.Input == Control, S.Failure == Never {
    guard let control = control else {
      subscriber.receive(completion: .finished)
      return
    }
    let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: events)
    subscriber.receive(subscription: subscription)
  }
}

extension UIControl {
  func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
    return UIControlPublisher(control: self, events: events)
  }
}
