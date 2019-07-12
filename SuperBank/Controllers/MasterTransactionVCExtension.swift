//
//  MasterTransactionVC+Extension.swift
//  SuperBank
//
//  Created by Shaher Kassam on 2019-07-12.
//  Copyright © 2019 Shaher. All rights reserved.
//

import UIKit

// DataSource Delegate
extension MasterTransactionVC {
    
    //Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.bank.accountDetails.groupedTransactionsPerDate.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bank.accountDetails.groupedTransactionsPerDate[section].value.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?  //Used UTC as a reference
        
        return dateFormatter.string(from: self.bank.accountDetails.groupedTransactionsPerDate[section].key)
    }
    
    //Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath)
        let transaction = self.bank.accountDetails.groupedTransactionsPerDate[indexPath.section].value[indexPath.row]
        let formatter = bank.frenchEuroFormatter()
        
        cell.textLabel?.text = transaction.description
        cell.detailTextLabel?.text = formatter.string(for: transaction.amount)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let transaction = self.bank.accountDetails.groupedTransactionsPerDate[indexPath.section].value[indexPath.row]
        let detailTransactionVC = UIStoryboard(name: "DetailTransaction", bundle: nil).instantiateViewController(withIdentifier: "DetailTransactionVC") as! DetailTransactionVC
        detailTransactionVC.transaction = transaction
        detailTransactionVC.formatter = bank.dutchEuroFormatter()
        
        self.navigationController?.pushViewController(detailTransactionVC, animated: true)
    }
    
}
