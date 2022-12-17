//
//  AddTransactionViewController.swift
//  my-expenses
//
//  Created by Esthefano Pastor on 5/12/22.
//

import UIKit

class FormTransaccionViewController: UIViewController {
    private var tipoTransaccion: String?
    
    var presenter: FormTransaccionPresenterInputProtocol?
    
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var cantidadTextField: UITextField!
    @IBOutlet weak var tipoButton: UIButton!
    @IBOutlet weak var categoriaButton: UIButton!
    @IBOutlet weak var fechaTextField: UITextField!
    @IBOutlet weak var notaTextView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage() // Remove default navigation bar shadow
        setupTypeButton()
    }
    
    @IBAction func didCancelTap(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func didDoneTap(_ sender: UIBarButtonItem) {
        guard let descripcion = descripcionTextField.text, !descripcion.isEmpty else { return }
        guard let cantidad = cantidadTextField.text, !cantidad.isEmpty else { return }
        guard let tipo = tipoButton.titleLabel?.text else { return }
        guard let categoria = categoriaButton.titleLabel?.text else { return }
        let fecha = fechaTextField.text ?? ""
        let nota = notaTextView.text ?? ""
        
        presenter?.didDoneTap(
            descripcion: descripcion,
            cantidad: cantidad,
            tipo: tipo,
            fecha: fecha,
            categoria: categoria,
            nota: nota
        )
    }
}

extension FormTransaccionViewController: FormTransaccionViewProtocol {
    func setupCategoriaButton(_ categorias: [CategoriaButtonEntity]) {
        let optionHandler = { (action: UIAction) in self.tipoTransaccion = action.title }
        let children = categorias.map {
            UIAction(title: $0.nombre, handler: optionHandler)
        }
        children[0].state = .on
        categoriaButton.menu = UIMenu(children: children)
        categoriaButton.showsMenuAsPrimaryAction = true
        categoriaButton.changesSelectionAsPrimaryAction = true
    }
}

extension FormTransaccionViewController {
    func setupTypeButton() {
        let optionHandler = { (action: UIAction) in self.tipoTransaccion = action.title }
        tipoButton.menu = UIMenu(children : [
            UIAction(title: "Gasto", state: .on, handler: optionHandler),
            UIAction(title: "Ingreso", handler: optionHandler),
        ])
        tipoButton.showsMenuAsPrimaryAction = true
        tipoButton.changesSelectionAsPrimaryAction = true
    }
}
