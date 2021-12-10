//
//  PrincipalViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import CoreData
import UIKit

// MARK: - PrincipalViewController

class PrincipalViewController: UIViewController {
    // MARK: Lifecycle

    init(com viewModel: PrincipalViewModel,
         coredata: CoreDataManager)
    {
        self.viewModel = viewModel
        self.coredata = coredata
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configurarNavBar()
    }

    override func loadView() {
        principalView.delegate = self
        view = principalView
    }

    // MARK: Private

    private let coredata: CoreDataManager
    private let viewModel: PrincipalViewModel

    private lazy var principalView: PrincipalView = {
        let view = PrincipalView(coredata: coredata)
        return view
    }()

    private lazy var carregandoView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()

    private func carregandoExibir() {
        view.addSubview(carregandoView)
        NSLayoutConstraint.activate([
            carregandoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carregandoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        carregandoView.startAnimating()
    }

    private func carregandoOcultar() {
        carregandoView.stopAnimating()
    }

    private func configurarNavBar() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                            target: self,
                                            action: #selector(adicionarButtonTapped))
        navigationItem.rightBarButtonItem = addButtonItem
        navigationItem.title = "Listagem"

        let icone = UIImage(systemName: "gearshape.fill")!
        let configuracoesButtonItem = UIBarButtonItem(image: icone,
                                                      style: .done,
                                                      target: self,
                                                      action: #selector(configuracoesTapped))
        navigationItem.leftBarButtonItem = configuracoesButtonItem
    }

    @objc private func adicionarButtonTapped() {
        let vc = AdicionarEditarViewController(coredata: coredata)
        vc.title = "Adicionar"

        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.tintColor = .white
        nav.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
        showDetailViewController(nav, sender: self)
    }

    @objc private func configuracoesTapped() {
        let vc = ConfiguracoesViewController()
        showDetailViewController(vc, sender: nil)
    }
}

// MARK: - PrincipalViewDelegate

extension PrincipalViewController: PrincipalViewDelegate {
    func encomendaSelecionada(_ encomenda: Encomenda) {
        let viewModelDetalhes = DetalhesViewModel(encomenda: encomenda)
        self.carregandoExibir()

        viewModelDetalhes.carregamentoIniciado = {
            
        }

        viewModelDetalhes.carregamentoFinalizadoSucesso = {
            self.carregandoOcultar()
            let viewController = EncomendaDetalhesViewController(com: viewModelDetalhes)
            self.show(viewController, sender: self)
        }

        viewModelDetalhes.carregamentoFinalizadoErro = { erro in
            print("==52===:  erro", erro)
            self.carregandoOcultar()
        }
    }

    func selecionada(encomendaNo indexPath: IndexPath) {}

    func selecionouRowAt(_: IndexPath) {}

    func editarSelecionada(_ encomenda: Encomenda) {
        let vc = AdicionarEditarViewController(coredata: coredata, encomendaSelecionada: encomenda)
        vc.title = "Editar"

        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.tintColor = .white
        nav.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]

        showDetailViewController(nav, sender: self)
    }

//    func exibirSelecionada(_ encomenda: Encomenda) {
//        let vc = EncomendaDetalhesViewController(com: viewModel)
//        show(vc, sender: self)
//    }
}

// extension PrincipalViewController {
//    func bind() {
//        viewModel
//    }
// }
