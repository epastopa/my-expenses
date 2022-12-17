//
//  FormTransaccionesProtocols.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 17/12/22.
//

import Foundation

protocol FormTransaccionViewProtocol {
    func setupCategoriaButton(_ categorias: [CategoriaButtonEntity])
}

protocol FormTransaccionInteractorProtocol {
    func add(_ transaccion: TransaccionAgregadaEntity)
    func categorias()
}

protocol FormTransaccionPresenterInputProtocol {
    func viewWillAppear()
    func didDoneTap(descripcion: String, cantidad: String, tipo: String, fecha: String, categoria: String, nota: String)
}

protocol FormTransaccionPresenterOutputProtocol {
    func obtenerCategorias(_ categorias: [CategoriaResponse])
    func dismiss()
}

protocol FormTransaccionRouterProtocol {
    func dismiss()
}
