//
//  DetalhesViewModel.swift
//  TrackingBRApp
//
//  Created by Dairan on 06/12/21.
//

import Foundation

final class DetalhesViewModel {
    // MARK: Lifecycle

    internal init(encomenda: Encomenda, repositorio: Repositorio = Repositorio()) {
        self.encomenda = encomenda
        self.repositorio = repositorio

        carregamentoIniciado?()

        repositorio.obterRastreio(da: encomenda) { resultado in
            switch resultado {
                case let .success(rastreio):
                    self.rastreamento = rastreio
//                    self.removerHifen(do: rastreio)
                    self.carregamentoFinalizadoSucesso?()
                case .failure:
                    self.carregamentoFinalizadoErro?(.erroGenerico)
            }
        }
    }

    // MARK: Internal

    var carregamentoIniciado: (() -> Void)?
    var carregamentoFinalizadoSucesso: (() -> Void)?
    var carregamentoFinalizadoErro: ((ErroRepositorio) -> Void)?

    var encomenda: Encomenda
    var rastreamento: Rastreio?

    func rastreio(no indexPath: IndexPath) -> String {
        "\(rastreamento?.trackingEvents?[indexPath.row].eventDateTime ?? Date()) | \(rastreamento?.trackingEvents?[indexPath.row].eventLocation ?? "Sem localizacao")"
    }

//    func removerHifen(do rastreamento: Rastreio) {
//        guard var rastreios = rastreamento.trackingEvents else { return }
//        let rastr = rastreamento.trackingEvents?.filter( {$0.eventLocation == "-"})
//        for rastreio in rastreios {
//            if rastreio.eventLocation == "-" {
//                rastreio.eventLocation = ""
//            }
//        }
//    }

    // MARK: Private

    private var repositorio: Repositorio
}
