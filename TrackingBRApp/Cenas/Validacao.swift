//
//  Validacao.swift
//  TrackingBRApp
//
//  Created by Dairan on 15/12/21.
//

import Foundation

final class Validacao {
    static func validar(_ codigo: String) -> Bool {
        guard codigo.count > 13 else { return false }
        return true
    }

    static func validarRegex(_ codigo: String) -> Bool {
        guard codigo.range(of: #"\b([A-Z]{2})([0-9]{9})([A-Z]{2})\b"#, options: .regularExpression) != nil else { return false }
        return true
    }
}
