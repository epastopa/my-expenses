//
//  ListaPresupuestosViewController.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 14/12/22.
//

import UIKit

protocol ListaPresupuestosViewProtocol {
    func listar(_ presupuestos: [PresupuestoResponse])
}

class ListaPresupuestosViewController: UIViewController {
    private var presupuestos: [PresupuestoResponse] = []
    
    @IBOutlet weak var presupuestosTableView: UITableView!
    
    var presenter: ListaPresupuestosPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presupuestosTableView.dataSource = self
        presupuestosTableView.delegate = self
    }
    
    @IBAction func didAddTap(_ sender: UIBarButtonItem) {
        presenter?.presentarForm()
    }
}

extension ListaPresupuestosViewController: ListaPresupuestosViewProtocol {
    func listar(_ presupuestos: [PresupuestoResponse]) {
        self.presupuestos = presupuestos
        presupuestosTableView.reloadData()
    }
}

extension ListaPresupuestosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presupuestos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "presupuestoCell", for: indexPath)
        return cell
    }
}

extension ListaPresupuestosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentar()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
