//
//  PrincipalViewModel.swift
//  TrackingBR
//
//  Created by Dairan on 22/08/21.
//

import Foundation

// MARK: - PrincipalViewModel

class PrincipalViewModel {
  // MARK: Lifecycle

  init(respositorio: Repository = Repository()) {
    self.respositorio = respositorio
    obterDados()
  }

  // MARK: Internal

  var atualizarView: (() -> Void)?

  var rastreioResults = Bindable<Rastreio>()

  var rastreio: Rastreio? {
    didSet {
      print("dados carregados")
      atualizarView?()
    }
  }

  var titulo: String {
    return rastreio?.type ?? "não atualizou a view"
  }



  func obterDados() {
    respositorio.verificar { resultado in
      switch resultado {
        case .success(let rastreioResults):
          self.rastreio = rastreioResults
          self.rastreioResults.valor = rastreioResults
        case .failure(let erro):
          print("==24===:  erro", erro)
      }
    }
  }

  // MARK: Private

//  private let rastreio: [Rastreio]?
  private let respositorio: Repository
}

// MARK: - RastreioVM

//struct RastreioVM {
//  // MARK: Lifecycle
//
//  private let rastreio: Rastreio
//  init(rastreio: Rastreio) {
//    self.rastreio = rastreio
//  }
//
//  // MARK: Internal
//
//  var objeto: String {
//    rastreio.code
//  }
//
//  var titulo: String {
//    rastreio.type
//  }
//}
