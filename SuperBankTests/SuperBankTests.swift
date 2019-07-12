//
//  SuperBankTests.swift
//  SuperBankTests
//
//  Created by Shaher Kassam on 2019-07-04.
//  Copyright © 2019 Shaher. All rights reserved.
//

import XCTest
@testable import SuperBank

class SuperBankTests: XCTestCase {


    func testExample() {
        
        //given
        let trxRaw = TransactionRaw(
            id: "trx1",
            amount: "-18.20",
            description: "pizza",
            otherAccount: "NL18ABNA0484869868",
            date: "2018-05-14T14:19:00Z")
        
        let accountRaw =  AccountDetailsRaw(
            account: "NL30MOYO0001234567",
            balance: "100.20",
            transactions: [trxRaw])
        
        
        
        //when
        let account = AccountDetails(from: accountRaw)
        
        //then
        XCTAssertEqual(100.2, account.balance)
        XCTAssertEqual(-18.2, account.transactions[0].amount)
    }


}
