//
//  HomeViewController.swift
//  my-expenses
//
//  Created by Esthefano Pastor on 4/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var ingresosTotalesLabel: UILabel!
    @IBOutlet weak var gastosTotales: UILabel!
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var transactionsMocked = [
        Transaction(id: "b5615569-a59a-4d39-bcd9-fe4601997cda", name: "Burger", amount: 17, date: Date(), categoryId: "ABC", type: "gasto", description: "", images: [""]),
        Transaction(id: "1f7dcd58-153a-4079-876d-f4efc4eb72f7", name: "Shoes", amount: 199.99, date: Date(), categoryId: "DEF", type: "gasto", description: "Nice shoes", images: [""]),
        Transaction(id: "f3652ca5-446f-4d37-9ad7-9fcfdb3d3be4", name: "Dress", amount: 80, date: Date(), categoryId: "GHI", type: "gasto", description: "", images: [""]),
        Transaction(id: "56706c62-9047-4819-81a9-89ed14e3649e", name: "Sueldo", amount: 2500, date: Date(), categoryId: "JKL", type: "ingreso", description: "", images: [""])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionsTableView.dataSource = self
        transactionsTableView.delegate = self
        
        setupLabels()
    }
    
    func setupLabels() {
        let gastos = transactionsMocked.filter{ $0.type == "gasto" }
        let ingresos = transactionsMocked.filter{ $0.type == "ingreso" }
        var totalIngresos = 0.00
        var totalGastos = 0.00
        
        for ingreso in ingresos {
             totalIngresos += ingreso.amount
        }
        
        for gasto in gastos {
            totalGastos += gasto.amount
        }
        
        let balanceTotal = totalIngresos - totalGastos
        
        balanceLabel.text = "$\(String(balanceTotal))"
        ingresosTotalesLabel.text = "$\(String(totalIngresos))"
        gastosTotales.text = "$\(String(totalGastos))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as? UINavigationController
        
        if (segue.identifier == "TransactionDetailsSegue") {
            guard let destination = nav?.viewControllers.first as? TransactionDetailsViewController else { return }
            guard let selectedRow = transactionsTableView.indexPathForSelectedRow?.row else { return }
            
            let transaction = transactionsMocked[selectedRow]
            destination.transaction = transaction
            destination.delegate = self
        } else if (segue.identifier == "AddTransactionSegue") {
            guard let destination = nav?.viewControllers.first as? AddTransactionViewController else { return }
            destination.delegate = self
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsMocked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell else { return UITableViewCell() }
        
        let transaction = transactionsMocked[indexPath.row]
        let amountPrefix = transaction.type == "gasto" ? "-$" : "$"
        
        cell.nameLabel.text = transaction.name
        cell.montoLabel.text = amountPrefix + String(transaction.amount)
        cell.montoLabel.textColor = transaction.type == "gasto" ? UIColor.systemRed : UIColor.systemGreen
        cell.categoryIconImageView.tintColor = transaction.type == "gasto" ? UIColor.systemRed : UIColor.systemGreen
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: AddTransactionViewControllerDelegate {
    func addTransactionView(_ addTransactionView: AddTransactionViewController, didCreateTransaction newTransaction: Transaction) {
        transactionsMocked.append(newTransaction)
        transactionsTableView.reloadData()
        setupLabels()
    }
}

extension HomeViewController: TransactionDetailsViewControllerDelegate {
    func transactionDetailsView(_ transactionDetailsView: TransactionDetailsViewController, didRemoveTransaction transactionId: String) {
        transactionsMocked = transactionsMocked.filter{ $0.id != transactionId }
        transactionsTableView.reloadData()
        setupLabels()
    }
}
