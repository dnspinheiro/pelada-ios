//
//  Pelada.swift
//  pelada
//
//  Created by Usuário Convidado on 27/02/2019.
//  Copyright © 2019 Usuário Convidado. All rights reserved.
//

import Foundation
import UIKit

class Pelada: NSObject, NSCoding {
    
    var nome: String
    var quantidade: String
    var horario: String
    
    static let pastaDeDocumentos = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let caminhoURL = pastaDeDocumentos.appendingPathComponent("peladas")
    
    struct PropertyKey {
        static let nome = "nome"
        static let quantidade = "quantidade"
        static let horario = "horario"
    }
    
    init?(nome: String, quantidade: String, horario: String) {
        guard !nome.isEmpty else { return nil }
        guard !quantidade.isEmpty else { return nil }
        guard !horario.isEmpty else { return nil }
        
        self.nome = nome
        self.quantidade = quantidade
        self.horario = horario
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: PropertyKey.nome)
        aCoder.encode(quantidade, forKey: PropertyKey.quantidade)
        aCoder.encode(horario, forKey: PropertyKey.horario)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let nome = aDecoder.decodeObject(forKey: PropertyKey.nome) as? String else {return nil}
        guard let quantidade = aDecoder.decodeObject(forKey: PropertyKey.quantidade) as? String else {return nil}
        guard let horario = aDecoder.decodeObject(forKey: PropertyKey.horario) as? String else {return nil}
        
        self.init(nome: nome, quantidade: quantidade, horario: horario)
    }
}
