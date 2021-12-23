//
//  DetalhesViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 29/09/21.
//

import UIKit

// MARK: - EncomendaDetalhesViewController

class DetalhesViewController: UIViewController {
    // MARK: Lifecycle

    init(com viewModel: DetalhesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarGeral()
    }

    // MARK: Internal

    let viewModel: DetalhesViewModel

    // MARK: Private

    override func loadView() {
        super.loadView()
        let detalhesView = DetalhesView(viewModel: viewModel)
        detalhesView.delegate = self
        view = detalhesView
    }
}

// MARK: - ViewCode

extension DetalhesViewController: ViewCode {
    func configurar() {
        view.backgroundColor = .yellow
    }

    func configurarConstraits() {}

    func configurarView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.encomenda.codigo
    }
}

// MARK: - DetalhesViewDelegate

extension DetalhesViewController: DetalhesViewDelegate {
    func linhaSelecionada(no indice: IndexPath) {
        let rastreio = viewModel.rastreio(no: indice)
    }
}
