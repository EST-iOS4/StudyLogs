//
//  ContentView.swift
//  Calculator
//
//  Created by Jungman Bae on 8/5/25.
//

import SwiftUI

struct ContentView: View {
  @State private var formulaString = ""
  @State private var resultString = "0"

  var body: some View {
    VStack {
      VStack(alignment: .trailing) {
        Text(formulaString)
          .foregroundStyle(.gray)
        Text(resultString)
          .font(.system(size: 60))
          .lineLimit(1)
      }
      .frame(maxWidth: .infinity, minHeight: 200, alignment: .trailing)
      HStack {
        Button {
          formulaString = ""
          resultString = "0"
        } label: {
          Text("AC")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
          .buttonStyle(.bordered)
        Button {} label: {
          Text("+/-")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
          .buttonStyle(.bordered)
        Button {
          appendToFormula("%")
        } label: {
          Text("%")
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("÷")
        } label: {
          Text("÷")
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .buttonStyle(.bordered)

      }
      HStack {
        Button {
          appendToFormula("7")
        } label: {
          Text("7")
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("8")
        } label: {
          Text("8")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("9")
        } label: {
          Text("9")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("×")
        } label: {
          Text("×")
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .buttonStyle(.bordered)
      }
      HStack {
        Button {
          appendToFormula("4")
        } label: {
          Text("4")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("5")
        } label: {
          Text("5")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("6")
        } label: {
          Text("6")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("−")
        } label: {
          Text("−")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
      }
      HStack {
        Button {
          appendToFormula("1")
        } label: {
          Text("1")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("2")
        } label: {
          Text("2")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("3")
        } label: {
          Text("3")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("+")
        } label: {
          Text("+")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
      }
      HStack {
        Button {} label: {
          Text("📱")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          appendToFormula("0")
        } label: {
          Text("0")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {} label: {
          Text(".")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.bordered)
        Button {
          calculateResult()
        } label: {
          Text("=")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    if formulaString.isEmpty && value == "0" {
      // Prevent leading zero
      return
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
    resultString = "Calculating..."
  }
}

#Preview {
  ContentView()
}
