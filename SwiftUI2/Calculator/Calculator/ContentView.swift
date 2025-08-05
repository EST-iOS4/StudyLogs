//
//  ContentView.swift
//  Calculator
//
//  Created by Jungman Bae on 8/5/25.
//

import SwiftUI

struct ContentView: View {
  @State private var formulaString = ""
  @State private var resultString = ""

  var body: some View {
    VStack(alignment: .trailing) {
      Text(formulaString)
        .foregroundStyle(.gray)
      Text(resultString)
        .font(.custom("Helvetica Neue", size: 72))
      HStack {
        Button {} label: {
          Text("AC")
        }
          .buttonStyle(.bordered)
        Button {} label: {
          Text("+/-")
        }
          .buttonStyle(.bordered)
        Button {} label: {
          Text("%")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("÷")
        }
        .buttonStyle(.bordered)

      }
      HStack {
        Button {
          appendToFormula("7")
        } label: {
          Text("7")
        }
        .buttonStyle(.bordered)
        Button {

        } label: {
          Text("8")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("9")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("×")
        }
        .buttonStyle(.bordered)
      }
      HStack {
        Button {} label: {
          Text("4")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("5")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("6")
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("−")
        } label: {
          Text("−")
        }
        .buttonStyle(.bordered)
      }
      HStack {
        Button {} label: {
          Text("1")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("2")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("3")
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("+")
        } label: {
          Text("+")
        }
        .buttonStyle(.bordered)
      }
      HStack {
        Button {} label: {
          Text("📱")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text("0")
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text(".")
        }
        .buttonStyle(.bordered)
        Button {
          calculateResult()
        } label: {
          Text("=")
        }
        .buttonStyle(.bordered)
      }
    }
    .font(.largeTitle)
    .padding()
  }

  private func appendToFormula(_ value: String) {
    // Check if the last character is an operator
    if let lastCharacter = formulaString.last, "+−×÷".contains(lastCharacter) && "+−×÷".contains(value) {
      // If the last character is an operator, replace it with the new value
      formulaString.removeLast()
    }
    formulaString += value
  }

  private func calculateResult() {
    // Implement the logic to calculate the result based on the formulaString
    // For now, just set resultString to a placeholder value
    let numbers = formulaString.components(separatedBy: CharacterSet(charactersIn: "+−×÷"))
    print("Numbers: \(numbers)")
    let operators = formulaString.filter { "+−×÷".contains($0) }
    print("Operators: \(operators)")
    resultString = "Result"
  }
}

#Preview {
  ContentView()
}
