//
//  TrackingBRAppTests.swift
//  TrackingBRAppTests
//
//  Created by Dairan on 21/10/21.
//

import XCTest
@testable import TrackingBRApp

class TrackingBRAppTests: XCTestCase {

  func test_habilitandoBotaoSalvarAoAlcancar13caracteres() {

    let viewModel = AdicionarEditarViewModel()
    let encomendaParaTestar = EncomendaParaAdicionarDTO(codigo: "codigo",
                                              descricao: "descricao",
                                              data: nil)

    let sut = AdicionarEditarView(with: viewModel)
    sut.encomenda = encomendaParaTestar


  }
}
