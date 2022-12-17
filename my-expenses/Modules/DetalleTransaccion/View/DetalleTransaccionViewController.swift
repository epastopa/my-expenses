//
//  TransactionDetailsViewController.swift
//  my-expenses
//
//  Created by Esthefano Pastor on 5/12/22.
//

import UIKit

class DetalleTransaccionViewController: UIViewController {
    var presenter: DetalleTransaccionPresenterInputProtocol?

    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var cantidadLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var categoriaLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var notaTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage() // Remove default navigation bar shadow
    }
    
    @IBAction func didDeleteTap(_ sender: UIBarButtonItem) {
        presenter?.didTrashTap()
    }
}

extension DetalleTransaccionViewController {
    func setup() {
        let detalle = presenter?.getDetalleInfo()

        descripcionLabel.text = detalle?.descripcion
        cantidadLabel.text = detalle?.cantidad
        tipoLabel.text = detalle?.tipo
        fechaLabel.text = detalle?.fecha
        categoriaLabel.text = detalle?.categoria
        notaTextView.text = detalle?.nota
    }
}

extension DetalleTransaccionViewController: DetalleTransaccionViewProtocol {
    func showDetalle() {
        setup()
    }
}
