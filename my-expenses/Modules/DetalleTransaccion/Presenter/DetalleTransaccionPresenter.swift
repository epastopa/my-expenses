//
//  DetalleTransaccionPresenter.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 15/12/22.
//

import Foundation

class DetalleTransaccionPresenter {
    private var detalleId: String
    var detalle: DetalleTransaccionViewModel?
    var view: DetalleTransaccionViewProtocol?
    var interactor: DetalleTransaccionInteractorProtocol?
    var router: DetalleTransaccionRouterProtocol?
    
    required init(id: String) {
        self.detalleId = id
    }
}

extension DetalleTransaccionPresenter: DetalleTransaccionPresenterInputProtocol {
    func viewWillAppear() {
        interactor?.transaccion(detalleId)
    }
    
    func getDetalleInfo() -> DetalleTransaccionViewModel? {
        return detalle
    }
    
    func didTrashTap() {
        interactor?.eliminar(por: detalleId)
    }
}

extension DetalleTransaccionPresenter: DetalleTransaccionPresenterOutputProtocol {
    func showDetalle(_ detalle: DetalleTransaccionEntity) {
        let cantidad = "$\(detalle.cantidad)"
        
        self.detalle = DetalleTransaccionViewModel(
            id: detalle.id,
            descripcion: detalle.descripcion,
            cantidad: cantidad,
            fecha: detalle.fecha,
            categoria: detalle.categoria,
            tipo: detalle.tipo,
            nota: detalle.nota
        )
        
        view?.showDetalle()
    }
    
    func dismiss() {
        router?.dismiss()
    }
}
