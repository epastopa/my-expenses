//
//  DetalleTransaccionInteractor.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 15/12/22.
//

import Foundation



class DetalleTransaccionInteractor {
    var presenter: DetalleTransaccionPresenterOutputProtocol?
    var api: RemoteRepository?
    
    required init (presenter: DetalleTransaccionPresenterOutputProtocol, api: RemoteRepository) {
        self.presenter = presenter
        self.api = api
    }
}

extension DetalleTransaccionInteractor: DetalleTransaccionInteractorProtocol {
    @MainActor
    func transaccion(_ id: String) {
        Task.init {
            guard let transaccion = await api?.fetchTransaccion(por: id) else { return }
            guard let categoria = await api?.fetchCategoria(por: transaccion.categoriaId) else { return }
            
            let detalle = DetalleTransaccionEntity(id: transaccion.id!, descripcion: transaccion.descripcion, cantidad: transaccion.cantidad, fecha: transaccion.fecha, categoria: categoria.nombre, tipo: transaccion.tipo, nota: transaccion.nota)
            presenter?.showDetalle(detalle)
        }
    }
    
    @MainActor
    func eliminar(por id: String) {
        Task.init {
            await api?.deleteTransaccion(por: id)
            presenter?.dismiss()
        }
    }
}
