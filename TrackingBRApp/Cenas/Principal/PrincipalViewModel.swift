//
//  PrincipalViewModel.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import CoreData
import Foundation

// MARK: - PrincipalViewModel

class PrincipalViewModel {
    // MARK: Lifecycle

    init(coreData: CoreDataManager, repositorio: Repositorio) {
        self.coreData = coreData
        self.repositorio = repositorio
    }

    // MARK: Internal

    var atualizarView: (() -> Void)?
    var encomendas: [Encomenda]?

    private(set) var encomendaSelecionada: Encomenda?

    var rastreio: Rastreio? { didSet { atualizarView?() } }

    func selecionar(encomendaNo indexPath: IndexPath) -> Encomenda {
        coreData.fetchResultController.object(at: indexPath)
    }

    func apagar(encomenda: Encomenda) {
        coreData.apagar(encomenda: encomenda)
    }

    // MARK: Private

    private var repositorio: Repositorio
    private var coreData: CoreDataManager
}
