//
//  ViewCode.swift
//  TrackingBRApp
//
//  Created by Dairan on 11/12/21.
//

import Foundation

protocol ViewCode {
    func configurar()
    func configurarConstraits()
    func configurarView()
}

extension ViewCode {
    func configurarGeral() {
        configurar()
        configurarView()
        configurarConstraits()
    }
}
