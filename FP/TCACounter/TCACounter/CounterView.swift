//
//  ContentView.swift
//  TCACounter
//
//  Created by Jungman Bae on 10/30/25.
//

import SwiftUI

struct CounterView: View {
  // MARK: - Properties
  @State private var viewModel = CounterViewModel(
    store: Store.counter()
  )
//  @ObservedObject var store: Store<CounterState, CounterAction, CounterEnvironment>

  // MARK: - Body

  var body: some View {
    VStack(spacing: 30) {

      // MARK: - 제목

      Text("TCA Counter")
        .font(.largeTitle)
        .fontWeight(.bold)

      // MARK: - 카운트 표시
      ZStack {
        Text("\(viewModel.count)")
          .font(.system(size: 80, weight: .bold, design: .rounded))
          .foregroundColor(.primary)
          .opacity(viewModel.isLoading ? 0.3 : 1.0)

        if viewModel.isLoading {
          ProgressView()
            .scaleEffect(2.0)
        }
      }
      .frame(height: 120)

      // MARK: - 에러 메시지

      if let errorMessage = viewModel.errorMessage {
        VStack(spacing: 10) {
          HStack {
            Image(systemName: "exclamationmark.triangle.fill")
              .foregroundColor(.red)

            Text(errorMessage)
              .foregroundColor(.red)
              .font(.callout)
          }
          .padding()
          .background(Color.red.opacity(0.1))
          .cornerRadius(10)

          Button("에러 제거") {
            viewModel.clearError()
          }
          .font(.caption)
          .foregroundColor(.red)
        }
      }

      // MARK: - 기본 버튼

      HStack(spacing: 20) {
        Button {
          viewModel.decrement()
        } label: {
          Image(systemName: "minus.circle.fill")
            .font(.system(size: 50))
            .foregroundColor(.red)
        }
        .disabled(viewModel.isLoading)

        Button {
          viewModel.increment()
        } label: {
          Image(systemName: "plus.circle.fill")
            .font(.system(size: 50))
            .foregroundColor(.green)
        }
        .disabled(viewModel.isLoading)
      }

      // MARK: - 비동기 증가 버튼

      Button {
        viewModel.asyncIncrementTapped()
      } label: {
        HStack {
          if viewModel.isLoading {
            ProgressView()
              .progressViewStyle(CircularProgressViewStyle(tint: .white))
          } else {
            Image(systemName: "arrow.up.circle.fill")
          }
          Text("비동기 증가 (2초 지연)")
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(viewModel.isLoading ? Color.gray : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
      }
      .disabled(viewModel.isLoading)
      .padding(.horizontal)

      // MARK: - 리셋 버튼

      Button {
        viewModel.reset()
      } label: {
        Text("리셋")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.orange)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
      .disabled(viewModel.isLoading)
      .padding(.horizontal)

      Spacer()
    }
    .padding()
  }
}

// MARK: - Preview
#Preview {
  CounterView()
}
