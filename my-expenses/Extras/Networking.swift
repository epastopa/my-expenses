//
//  Networking.swift
//  my-expenses
//
//  Created by Esthefano Oniel Pastor Palacios on 14/12/22.
//

import Foundation
import FirebaseFirestore

protocol RemoteRepository {
    func fetchTransacciones() async -> [TransaccionResponse]
    func fetchTransaccion(por id: String) async -> TransaccionResponse?
    func add(_ transaccion: TransaccionAgregadaEntity) async -> Void
    func fetchCategorias() async -> [CategoriaResponse]
    func fetchCategoria(por id: String) async -> CategoriaResponse?
    func deleteTransaccion(por id: String) async -> Void
    
    func fetchPresupuestos() async throws -> [PresupuestoResponse]
}

class FirebaseAPI: RemoteRepository {
    private let db = Firestore.firestore()
    
    // TODO: retornar errores
    func fetchTransacciones() async -> [TransaccionResponse] {
        let colRef = db.collection("transaccion")
        
        do {
            let querySnapshot = try await colRef.getDocuments()
            let data = try querySnapshot.documents.compactMap { document in
                return try document.data(as: TransaccionResponse.self)
            }
            return data
        } catch {
            print("Error")
            return []
        }
    }
    
    // TODO: retornar errores
    func fetchTransaccion(por id: String) async -> TransaccionResponse? {
        let colRef = db.collection("transaccion")
        
        do {
            let querySnapshot = colRef.document(id)
            let data = try await querySnapshot.getDocument().data(as: TransaccionResponse.self)
            return data
        } catch {
            print("Error")
            return nil
        }
    }
    
    // TODO: retornar errores
    func add(_ transaccion: TransaccionAgregadaEntity) async {
        let colRef = db.collection("transaccion")
        let docRef = colRef.document()
        
        do {
            try await docRef.setData([
                "descripcion": transaccion.descripcion,
                "cantidad": transaccion.cantidad,
                "categoriaId": transaccion.categoriaId,
                "fecha": transaccion.fecha,
                "nota": transaccion.nota,
                "tipo": transaccion.tipo
            ])
        } catch {
            print("Error")
        }
    }
    
    // TODO: retornar errores
    func fetchCategorias() async -> [CategoriaResponse] {
        let colRef = db.collection("categoria")
        do {
            let querySnapshot = try await colRef.getDocuments()
            let data = querySnapshot.documents.compactMap { document in try? document.data(as: CategoriaResponse.self) }
            return data
        } catch {
            return []
        }
    }
    
    
    // TODO: retornar errores
    func fetchCategoria(por id: String) async -> CategoriaResponse? {
        let colRef = db.collection("categoria")
        
        do {
            let querySnapshot = colRef.document(id)
            let data = try await querySnapshot.getDocument().data(as: CategoriaResponse.self)
            return data
        } catch {
            print("Error")
            return nil
        }
    }
    
    // TODO: retornar errores
    func deleteTransaccion(por id: String) async {
        let colRef = db.collection("transaccion")
        let docRef = colRef.document(id)
        
        do {
//            try await docRef.delete()
            try await docRef.delete()
        } catch {
            print("Error")
        }
    }

    func fetchPresupuestos() async throws -> [PresupuestoResponse] {
        let docRef = db.collection("presupuesto")
        let querySnapshot = try await docRef.getDocuments()
        return querySnapshot.documents.compactMap { document in try? document.data(as: PresupuestoResponse.self) }
    }
    
    
}
