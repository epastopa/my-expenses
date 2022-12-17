//
//  DetalleTransaccionesRouter.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 15/12/22.
//

import UIKit

class DetalleTransaccionRouter {
    var view: UIViewController?
    var delegate: DetalleTransaccionBuilderDelegate
    
    required init(delegate: DetalleTransaccionBuilderDelegate) {
        self.delegate = delegate
    }
}

extension DetalleTransaccionRouter: DetalleTransaccionRouterProtocol {
    func dismiss() {
        view?.dismiss(animated: true)
        delegate.detalleTransaccionBuilder(didDelete: view!)
    }
}
