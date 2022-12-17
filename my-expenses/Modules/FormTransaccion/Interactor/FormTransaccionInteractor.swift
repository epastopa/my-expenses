//
//  FormTransaccionInteractor.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 15/12/22.
//

import Foundation

class FormTransaccionInteractor {
    var presenter: FormTransaccionPresenterOutputProtocol?
    var api: RemoteRepository?
    
    required init(presenter: FormTransaccionPresenterOutputProtocol, api: RemoteRepository) {
        self.presenter = presenter
        self.api = api
    }
}

extension FormTransaccionInteractor: FormTransaccionInteractorProtocol {
    @MainActor
    func add(_ transaccion: TransaccionAgregadaEntity) {
        Task.init {
            await api?.add(transaccion)
            presenter?.dismiss()
        }
    }
    
    @MainActor
    func categorias() {
        Task.init {
            guard let categorias = await api?.fetchCategorias() else { return }
            presenter?.obtenerCategorias(categorias)
        }
    }
}
