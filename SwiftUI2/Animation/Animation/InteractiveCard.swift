//
//  InteractiveCard.swift
//  Animation
//
//  Created by Jungman Bae on 8/7/25.
//

import SwiftUI

struct InteractiveCard: View {
  @State private var offset = CGSize.zero
  @State private var scale: CGFloat = 1.0
  @State private var rotation: Double = 0
  @State private var isFlipped = false

  var body: some View {
    ZStack {
      // 뒷면
      RoundedRectangle(cornerRadius: 20)
        .fill(
          LinearGradient(
            colors: [.purple, .blue],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(width: 300, height: 200)
        .overlay(
          Text("뒷면")
            .font(.largeTitle)
            .foregroundColor(.white)
        )
        .rotation3DEffect(
          .degrees(isFlipped ? 0 : 180),
          axis: (x: 0, y: 1, z: 0)
        )
        .opacity(isFlipped ? 1 : 0)

      // 앞면
      RoundedRectangle(cornerRadius: 20)
        .fill(
          LinearGradient(
            colors: [.orange, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .frame(width: 300, height: 200)
        .overlay(
          VStack {
            Image(systemName: "creditcard")
              .font(.system(size: 50))
            Text("카드 앞면")
              .font(.title)
          }
            .foregroundColor(.white)
        )
        .rotation3DEffect(
          .degrees(isFlipped ? -180 : 0),
          axis: (x: 0, y: 1, z: 0)
        )
        .opacity(isFlipped ? 0 : 1)
    }
    .offset(offset)
    .scaleEffect(scale)
    .rotationEffect(.degrees(rotation))
    .gesture(
      DragGesture()
        .onChanged { value in
          offset = value.translation

          // 드래그 거리에 따른 회전
          let dragAmount = sqrt(
            value.translation.width * value.translation.width +
            value.translation.height * value.translation.height
          )
          rotation = Double(dragAmount / 10)
        }
        .onEnded { value in
          withAnimation(.spring()) {
            offset = .zero
            rotation = 0

            // 스와이프로 카드 뒤집기
            if abs(value.translation.width) > 100 {
              isFlipped.toggle()
            }
          }
        }
    )
    .onTapGesture(count: 2) {
      withAnimation(.spring()) {
        isFlipped.toggle()
      }
    }
    .simultaneousGesture(
      MagnificationGesture()
        .onChanged { value in
          scale = value
        }
        .onEnded { _ in
          withAnimation(.spring()) {
            scale = 1.0
          }
        }
    )
  }
}

#Preview {
  InteractiveCard()
}
