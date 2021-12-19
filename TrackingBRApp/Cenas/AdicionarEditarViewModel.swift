//
//  AdicionarEditarViewModel.swift
//  TrackingBRApp
//
//  Created by Dairan on 15/12/21.
//

import Foundation


final class AdicionarEditarViewModel {

    private(set) var encomenda: EncomendaParaSalvarDTO?

    func salvar(_ encomenda: EncomendaParaSalvarDTO) {
        self.encomenda = encomenda
    }
}
