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

    // 입력이 없을때, set resultString to "0"
    if numbers.isEmpty {
      resultString = "0"
      return
    }

    // 연산자 입력이 없을때, set resultString to the first number
    if numbers.count == 1 && operators.isEmpty {
      // If there's only one number and no operators, just return that number
      resultString = numbers[0]
      return
    }

    var result = Double(numbers[0]) ?? 0.0

    var tempNumbers = numbers
    var tempOperators = Array(operators)
    var i = 0

    while i < tempOperators.count {
      // 연산자 중 곱셈과 나눗셈의 경우 그 연산자 먼저 계산
      if tempOperators[i] == "×" || tempOperators[i] == "÷" {

        let leftNumber = Double(tempNumbers[i]) ?? 0.0
        let rightNumber = Double(tempNumbers[i + 1]) ?? 0.0

        if tempOperators[i] == "×" {
          result = leftNumber * rightNumber
        } else if tempOperators[i] == "÷" {
          if rightNumber != 0 {
            result = leftNumber / rightNumber
          } else {
            resultString = "Error"
            return
          }
        }

        // Replace the processed numbers and operators
        tempNumbers.remove(at: i + 1)
        tempNumbers[i] = String(result)
        tempOperators.remove(at: i)
      } else {
        i += 1
      }
    }

    result = Double(tempNumbers[0]) ?? 0.0

    for (index, operatorSymbol) in tempOperators.enumerated() {
      guard index < numbers.count - 1 else { break } // Ensure we don't go out of bounds
      let nextNumber = Double(tempNumbers[index + 1]) ?? 0.0

      switch operatorSymbol {
      case "+":
        result += nextNumber
      case "−":
        result -= nextNumber
      default:
        break
      }
    }

    // 소수점 없는 경우 출력
    if result.truncatingRemainder(dividingBy: 1) == 0 {
      resultString = String(format: "%g", result) // %g will format the number without decimal places if it's an integer
    } else {
      // 소수점 있는 경우 출력
      // 문자열 출력에서 %f 는 소수점 출력
      // %d 는 정수 출력
      // %g 는 소수점이 없는 정수 출력
      // %s 는 문자열 출력
      resultString = String(format: "%.2f", result) // %f will format the number with decimal places
    }
  }
}

#Preview {
  ContentView()
}
