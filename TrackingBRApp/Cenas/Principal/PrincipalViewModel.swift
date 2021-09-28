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

  init(coreData: GerenciadorCoreData, repositorio: Repositorio) {
    self.gerenciadorCoreData = coreData
    self.repositorio = repositorio
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

  // MARK: Private

  private var repositorio: Repositorio?
  private var gerenciadorCoreData: GerenciadorCoreData?

  private func obterDados() {
    repositorio?.verificar(aoTerminar: { resultado in
      switch resultado {
      case let .success(rastreio):
//        print("==28===:  rastreio", rastreio)
          break
      case let .failure(erro):
        print("==33===:  erro", erro)
      }
    })
  }
}
