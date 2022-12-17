//
//  DetalleTransaccionProtocols.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 17/12/22.
//

import Foundation

protocol DetalleTransaccionInteractorProtocol {
    func transaccion(_ id: String)
    func eliminar(por id: String)
}

protocol DetalleTransaccionPresenterInputProtocol {
    func viewWillAppear()
    func getDetalleInfo() -> DetalleTransaccionViewModel?
}

protocol DetalleTransaccionPresenterOutputProtocol {
    func showDetalle(_ detalle: DetalleTransaccionEntity)
}
