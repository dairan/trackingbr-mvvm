//
//  PrincipalViewModel.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import Foundation

// MARK: - PrincipalViewModel

class PrincipalViewModel {
  // MARK: Lifecycle

  init(respositorio: Repositorio = Repositorio()) {
    self.respositorio = respositorio
    obterDados()
  }

  // MARK: Internal

  var atualizarView: (() -> Void)?

//  var rastreioResults = Bindable<Rastreio>()

  var rastreio: Rastreio? {
    didSet {
      atualizarView?()
    }
  }

  var titulo: String {
    rastreio?.postedAt ?? "não atualizou a view"
  }

  func obterDados() {
    respositorio.verificar { resultado in
      switch resultado {
        case .success(let rastreioResultados):
          self.rastreio = rastreioResultados
//          self.rastreioResults.valor = rastreioResults
        case .failure(let erro):
          print("==24===:  erro", erro)
      }
    }
  }

  // MARK: Private

  private let respositorio: Repositorio

}
