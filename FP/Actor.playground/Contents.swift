import Foundation

actor BankAccount: Sendable {
  private var balance: Decimal
  private let accountNumber: String

  init(balance: Decimal, accountNumber: String) {
    self.balance = balance
    self.accountNumber = accountNumber
  }

  func depoit(_ amount: Decimal) {
    balance += amount
  }

  func getBalance() -> Decimal {
    return balance
  }
}

//class OldBankAccount {
//  private var balance: Decimal
//  private let accountNumber: String
//
//  init(balance: Decimal, accountNumber: String) {
//    self.balance = balance
//    self.accountNumber = accountNumber
//  }
//
//  func depoit(_ amount: Decimal) {
//    balance += amount
//  }
//
//  func getBalance() -> Decimal {
//    return balance
//  }
//}


Task {
  let account = BankAccount(balance: 1000, accountNumber: "123456")
  let oldAccount = OldBankAccount(balance: 1000, accountNumber: "000000")

  await withTaskGroup(of: Void.self) { group in
    for i in 1...10 {
      group.addTask {
        await account.depoit(Decimal(i * 100))
      }
    }
  }
  let balance = await account.getBalance()

  print("balance: \(balance)")
}
