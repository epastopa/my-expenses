//
//  ListaCategoriasBuilder.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 14/12/22.
//

import Foundation
import UIKit

class ListaCategoriasBuilder {
    static func build() -> UIViewController {
        let presenter = ListaCategoriasPresenter()
        
        let api = FirebaseAPI()
        let interactor = ListaCategoriasInteractor(presenter: presenter, api: api)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let view = storyboard.instantiateViewController(withIdentifier: "ListaCategoriasViewController") as! ListaCategoriasViewController
        view.tabBarItem.image = UIImage(systemName: "basket.fill")
        view.title = "Categorías"
        
        let router = ListaCategoriasRouter()
        router.presenter = presenter
        router.view = view
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        view.presenter = presenter
        
        return view
    }
}
