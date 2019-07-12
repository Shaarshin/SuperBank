//
//  Bank.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-12.
//  Copyright © 2019 Shaher. All rights reserved.
//

import RxSwift

public class Bank: AccountManagement {
    
    var accountDetails = AccountDetails()
   
    required public init() {
        self.openAccount()
    }

    func getAccountDetails() -> AccountDetails {
        return self.accountDetails
    }
    
    private func openAccount() {
        //Rx Example or not
        self.loadAcountDetailsRx()
        //self.loadAcountDetails()
    }
    
    private func loadAcountDetailsRx() {
        //Get Info from API
        //Example with Rx Swift
        
        API.shared.loadJSONfromfileRx().subscribe { event in
            switch event {
            case .next(let accountDetails):
                self.dailyAccountOperations(accountDetails)
            case .error(let error):
                print("No JSON file found")
                print(error)
            case .completed:
                //Just for show
                print("Loading Completed")
            }
            }.disposed(by: DisposeBag())
    }
    
    private func loadAcountDetails() {
        //Get Info from API
        //Example without Rx Swift
        
        API.shared.loadJSONfromfile(completion: {
            self.dailyAccountOperations($0)
        })
    }
    
    func dailyAccountOperations(_ accountDetails: AccountDetails) {
        self.accountDetails = accountDetails
        let accountBalanced = self.calculateBalances(accountDetails)
        self.accountDetails.groupedTransactionsPerDate = self.groupedTransactionsPerDate(accountBalanced)
    }
}
