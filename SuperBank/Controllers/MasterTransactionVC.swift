//
//  MasterTransationVC.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-04.
//  Copyright © 2019 Shaher. All rights reserved.
//

import UIKit
import RxSwift

class MasterTransactionVC: UITableViewController {
    
    @IBOutlet var transactionsListTV: UITableView!
    
    var bank = Bank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView(bank.accountDetails)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setupBackButton()
    }

    private func setupView(_ accountDetails: AccountDetails) {
        let formatter = bank.frenchEuroFormatter()
        let balanceString = formatter.string(for: accountDetails.balance)
        self.title = "Balance: " + (balanceString ?? String())
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
    }
}
