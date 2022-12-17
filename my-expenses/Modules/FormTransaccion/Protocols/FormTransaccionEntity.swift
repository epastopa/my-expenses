//
//  FormTransaccionEntity.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 17/12/22.
//

import Foundation

struct CategoriaButtonEntity {
    let id: String
    let nombre: String
}

struct TransaccionAgregadaEntity {
    let descripcion: String
    let cantidad: Double
    let categoriaId: String
    let fecha: String
    let nota: String
    let tipo: String
}
