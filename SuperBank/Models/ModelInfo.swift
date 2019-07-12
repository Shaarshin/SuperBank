//
//  ModelInfo.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-07.
//  Copyright © 2019 Shaher. All rights reserved.
//

import UIKit

//JSON Raw Result
struct AccountDetailsRaw: Decodable {
    var account: String
    var balance: String
    var transactions: [TransactionRaw]
}

struct TransactionRaw: Decodable {
    var id = String()
    var amount = String()
    var description = String()
    var otherAccount = String()
    var date = String()
}

//Transform JSONRaw String into AccountDetails object
public struct AccountDetails {
    var account = String()
    var balance = Decimal()
    var transactions: [Transaction] = []
    var groupedTransactionsPerDate = [(key: Date, value: [Transaction])]()
    
    init(from raw: AccountDetailsRaw) {
        account = raw.account
        if let balance = Decimal(string: raw.balance) {self.balance = balance}
        transactions = raw.transactions.map { Transaction(from: $0) }
    }
    
    init() {
    //Convenience Empty init
    }
}

struct Transaction: Decodable {
    var id: String
    var amount = Decimal()
    var description: String
    var otherAccount: String
    var date: Date //Full Date
    var calDate: Date //Calendar Date
    var calDateString: String
    var previousBalance = Decimal()
    var newBalance = Decimal()
    var time: Date
    var timeString: String
    
    init(from raw: TransactionRaw) {
        
        id = raw.id
        description = raw.description
        otherAccount = raw.otherAccount
        if let amount = Decimal(string: raw.amount) {self.amount = amount}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //Used UTC as a reference
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        date = dateFormatter.date(from:raw.date)!
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calDateString = dateFormatter.string(from:date)
        calDate = dateFormatter.date(from: calDateString)!
   
        dateFormatter.dateFormat = "HH:mm:ss"
        timeString = dateFormatter.string(from:date)
        time = dateFormatter.date(from: timeString)!
    }
}

