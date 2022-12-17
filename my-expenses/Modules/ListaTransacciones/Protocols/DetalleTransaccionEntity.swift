//
//  DetalleTransaccionEntity.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 17/12/22.
//

import Foundation

struct DetalleTransaccionEntity {
    let id: String
    var descripcion: String
    var cantidad: Double
    var fecha: String
    var categoria: String
    var tipo: String
    var nota: String
}

struct DetalleTransaccionViewModel {
    let id: String
    var descripcion: String
    var cantidad: String
    var fecha: String
    var categoria: String
    var tipo: String
    var nota: String
}
