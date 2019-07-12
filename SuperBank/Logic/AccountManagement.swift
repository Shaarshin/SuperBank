//
//  AccountManagement.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-12.
//  Copyright © 2019 Shaher. All rights reserved.
//

import Foundation

protocol AccountManagement {
    func calculateBalances(_ accountDetails: AccountDetails) -> AccountDetails
    func groupedTransactionsPerDate(_ accountDetails: AccountDetails) -> [(key: Date, value: [Transaction])]
    func frenchEuroFormatter() -> Formatter
    func dutchEuroFormatter() -> Formatter
}

extension AccountManagement {
    
    //Helpers
    
    func frenchEuroFormatter() -> Formatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .currency
        return formatter
    }
    
    func dutchEuroFormatter() -> Formatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        return formatter
    }
    
    // Managing Account
    
    internal func calculateBalances(_ accountDetails: AccountDetails) -> AccountDetails {
        
        var account = accountDetails
      
        let sortedTransactions = sortedTransactionsPerDate(account)
        var previousBalanceTemp = Decimal() // Storing the previous balance for calculation
        
        for i in 0..<accountDetails.transactions.count {
            var current = sortedTransactions[i]
            
            if current.id ==  sortedTransactions.first?.id {  //first transaction
                current.newBalance = accountDetails.balance
            } else {
                current.newBalance = previousBalanceTemp
            }
            
            current.previousBalance = current.newBalance - current.amount //calculate the balance
            previousBalanceTemp = current.previousBalance //saving balance for next transaction
            account.transactions[i] = current
        }
        
        return account
    }
    
    internal func groupedTransactionsPerDate(_ accountDetails: AccountDetails) -> [(key: Date, value: [Transaction])] {
        let transactions = accountDetails.transactions
        
        let groupedTransactions = Dictionary(grouping: transactions) { (element) -> Date in
            return element.calDate
        }
        
        return groupedTransactions.sorted { $0.0 > $1.0 }
    }
    
    //Private helper
    private func sortedTransactionsPerDate(_ accountDetails: AccountDetails) -> [Transaction] {
        //Creates a Table of Transaction sorted by date
        return Dictionary(grouping: accountDetails.transactions) {$0.date}.sorted {$0.0 > $1.0}.flatMap{$0.1}
    }
    
}
