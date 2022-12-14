//
//  ListaTransaccionesRouter.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 14/12/22.
//

import Foundation
import UIKit

class ListaTransaccionesRouter {
    private var detalleTransaccionBuilder: DetalleTransaccionBuilder?
    private var formTransaccionBuilder: FormTransaccionBuilder?
    
    var presenter: ListaTransaccionesPresenterOutputProtocol?
    var view: UIViewController?
}

extension ListaTransaccionesRouter: ListaTransaccionesRouterProtocol {
    func mostrarDetalle(_ id: String) {
        detalleTransaccionBuilder = DetalleTransaccionBuilder()
        detalleTransaccionBuilder?.delegate = self
        
        let detalleTransaccionViewController = detalleTransaccionBuilder!.build(id)
        view?.show(detalleTransaccionViewController, sender: nil)
    }
    
    func mostrarForm() {
        formTransaccionBuilder = FormTransaccionBuilder()
        formTransaccionBuilder?.delegate = self
        
        let formTransaccionViewController = formTransaccionBuilder!.build()
        view?.show(formTransaccionViewController, sender: nil)
    }
}

extension ListaTransaccionesRouter: DetalleTransaccionBuilderDelegate {
    func detalleTransaccionBuilder(didDelete viewController: UIViewController) {
        presenter?.updateUI()
    }
}

extension ListaTransaccionesRouter: FormTransaccionBuilderDelegate {
    func formTransaccionBuilder(didCreate viewController: UIViewController) {
        presenter?.updateUI()
    }
}
