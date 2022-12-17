//
//  DetalleTransaccionProtocols.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 17/12/22.
//

import Foundation

protocol DetalleTransaccionViewProtocol {
    func showDetalle()
}

protocol DetalleTransaccionInteractorProtocol {
    func transaccion(_ id: String)
    func eliminar(por id: String)
}

protocol DetalleTransaccionPresenterInputProtocol {
    func viewWillAppear()
    func getDetalleInfo() -> DetalleTransaccionViewModel?
    func didTrashTap()
}

protocol DetalleTransaccionPresenterOutputProtocol {
    func showDetalle(_ detalle: DetalleTransaccionEntity)
    func dismiss()
    
}

protocol DetalleTransaccionRouterProtocol {
    func dismiss()
}

