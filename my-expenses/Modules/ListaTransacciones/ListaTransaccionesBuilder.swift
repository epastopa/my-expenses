//
//  ListaTransaccionesBuilder.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 14/12/22.
//

import Foundation
import UIKit

class ListaTransaccionesBuilder {
    static func build() -> UIViewController {
        let presenter = ListaTransaccionesPresenter()
        
        let api = FirebaseAPI()
        let interactor = ListaTransaccionesInteractor(presenter: presenter, api: api)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let view = storyboard.instantiateViewController(withIdentifier: "ListaTransaccionesViewController") as! ListaTransaccionesViewController
        view.tabBarItem.image = UIImage(systemName: "tray.fill")
        view.title = "Home"
        
        let router = ListaTransaccionesRouter()
        router.presenter = presenter
        router.view = view
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
}
