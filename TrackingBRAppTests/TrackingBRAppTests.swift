//
//  TrackingBRAppTests.swift
//  TrackingBRAppTests
//
//  Created by Dairan on 21/10/21.
//

@testable import TrackingBRApp
import XCTest

class TrackingBRAppTests: XCTestCase {
    func test_habilitandoBotaoSalvarAoAlcancar13caracteres() {
//        let viewModel = AdicionarEditarViewModel()
        let encomendaParaTestar = EncomendaParaAdicionarDTO(codigo: "1234567890123",
                                                            descricao: "descricao",
                                                            data: nil)

        let sut = AdicionarEditarView(with: viewModel)
        sut.encomenda = encomendaParaTestar
        XCTAssert(sut.encomenda.codigo?.count == 13)
    }
}
