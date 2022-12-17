//
//  FormTransaccionPresenter.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 15/12/22.
//

import Foundation

class FormTransaccionPresenter {
    private var categorias: [CategoriaButtonEntity] = []
    
    var view: FormTransaccionViewProtocol?
    var interactor: FormTransaccionInteractorProtocol?
    var router: FormTransaccionRouterProtocol?
}

extension FormTransaccionPresenter: FormTransaccionPresenterInputProtocol {
    func viewWillAppear() {
        interactor?.categorias()
    }
    
    func didCancelTap() {
        router?.dismiss()
    }
    
    func didDoneTap(descripcion: String, cantidad: String, tipo: String, fecha: String, categoria: String, nota: String) {
        guard let cat = categorias.first(where: { $0.nombre == categoria }) else { return }
    
        let data = TransaccionAgregadaEntity(
            descripcion: descripcion,
            cantidad: Double(cantidad)!,
            categoriaId: cat.id,
            fecha: fecha,
            nota: nota,
            tipo: tipo
        )
        interactor?.add(data)
    }
}

extension FormTransaccionPresenter: FormTransaccionPresenterOutputProtocol {
    func obtenerCategorias(_ categorias: [CategoriaResponse]) {
        let mappedCategorias = categorias.map {
            CategoriaButtonEntity(id: $0.id!, nombre: $0.nombre)
        }
        self.categorias = mappedCategorias
        view?.setupCategoriaButton(mappedCategorias)
    }

    func dismiss() {
        router?.dismiss()
    }
}
