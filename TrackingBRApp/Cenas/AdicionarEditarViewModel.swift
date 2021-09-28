//
//  AdicionarEditarViewModel.swift
//  TrackingBRApp
//
//  Created by Dairan on 14/09/21.
//

import Foundation

struct EncomendaEstado {
  let codigo: String
  let descricao: String
  let data: String
}

class AdicionarEditarViewModel {
//  var encomendaEstado: EncomendaEstado

  init() {
//    self.encomendaEstado = encomenda
  }

  func criarEncomenda() {
    let contexto = GerenciadorCoreData.shared.contexto
    let encomenda = Encomenda(context: contexto)
//    encomenda.codigo = encomendaEstado.codigo
//    encomenda.descricao = encomendaEstado.descricao
  }

  func salvar() {
//    CoreDataGerenciador.shared.adicionar()
  }
}
