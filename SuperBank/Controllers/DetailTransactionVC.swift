//
//  DetailTransactionVC.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-05.
//  Copyright © 2019 Shaher. All rights reserved.
//

import UIKit

class DetailTransactionVC: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var otherAccountLabel: UILabel!
    @IBOutlet weak var oldBalanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var newBalanceLabel: UILabel!
    
    var transaction: Transaction?
    var formatter: Formatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard transaction != nil else {
            fatalError("you must provide a transaction before loading this controller")}
        
        guard formatter != nil else {
            fatalError("you must provide a formatter before loading this controller")}
        
        self.setupView()
    }
    
    func setupView() {
        guard let transaction = transaction, let formatter = formatter else {return}
        
        dateLabel.text = transaction.calDateString
        idLabel.text = transaction.id
        descriptionLabel.text = transaction.description
        otherAccountLabel.text = transaction.otherAccount
        oldBalanceLabel.text =  formatter.string(for: transaction.previousBalance)
        amountLabel.text = formatter.string(for: transaction.amount)
        newBalanceLabel.text = formatter.string(for: transaction.newBalance)
    }
    
}
