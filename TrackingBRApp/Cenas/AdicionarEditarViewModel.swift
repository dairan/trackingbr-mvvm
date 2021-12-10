////
////  AdicionarEditarViewModel.swift
////  TrackingBRApp
////
////  Created by Dairan on 14/09/21.
//
//
//import Foundation
//
//// MARK: - AdicionarEditarViewModelDelegate
//
//protocol AdicionarEditarViewModelDelegate: AnyObject {
//  func salvar()
//  func criar()
//}
//
//// MARK: - AdicionarEditarViewModel
//
//class AdicionarEditarViewModel {
//  // MARK: Internal
//
//  var atualizar: (() -> Void)?
//
//  // MARK: Private
//
////  var encomenda: EncomendaParaAdicionarDTO? {
////    didSet {
////      self.atualizar?()
////    }
////  }
//
//    func criarEncomenda(codigo: String, descricao: String? = nil, data: Date? = Date()) {
//        encomendaParaSalvar = EncomendaParaSalvarDTO(codigo: codigo,
//                               descricao: descricao,
//                               data: data)
//    }
//
//    private(set) var encomendaParaSalvar: EncomendaParaSalvarDTO?
//}
//
//// MARK: AdicionarEditarViewModelDelegate
//
//extension AdicionarEditarViewModel: AdicionarEditarViewModelDelegate {
//  func salvar() {
//  }
//
//  func criar() {
//  }
//}
