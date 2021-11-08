//
//  AdicionarEditarViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

// MARK: - AdicionarEditarViewController

class AdicionarEditarViewController: UIViewController {
    // MARK: Lifecycle

    init(coredata: GerenciadorCoreData) {
        self.coredata = coredata
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    override func loadView() {
        super.loadView()

        addEditarView.delegate = self
        view = addEditarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        obterDados()
    }

    // MARK: Private

    private var coredata: GerenciadorCoreData
    private let viewModel = AdicionarEditarViewModel()
    private lazy var addEditarView = AdicionarEditarView(with: viewModel)
    private var codigosEncontrados: [String]?

    private let cancelarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                        target: self,
                                        action: #selector(fecharDidTapped))
        return barButton
    }()

    private let salvarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save,
                                        target: self,
                                        action: #selector(salvarTapped))
        barButton.isEnabled = false
        return barButton
    }()

    private var encomendaParaSalvar: EncomendaParaAdicionarDTO?

    private func obterDados() {
        let repositorio = Repositorio()
//    repositorio.verificar(aoTerminar: { resultado in
//      switch resultado {
//      case let .success(rastreio):
//        print("==28===:  rastreio", rastreio ?? "")
//      case let .failure(erro):
//        print("==33===:  erro", erro)
//      }
//    })
        repositorio.obterDados()
    }

    private func navBarSetup() {
        navigationItem.leftBarButtonItem = cancelarButtonItem
        navigationItem.rightBarButtonItem = salvarButtonItem
    }

    private func dispensarView() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func fecharDidTapped() {
        dispensarView()
    }

    @objc private func salvarTapped() {
//    guard encomendaParaSalvar.codigo.isEmpty == false else { return }
//    coredata.adicionar(encomenda: encomendaParaSalvar)

        guard let encomendaParaSalvar = encomendaParaSalvar else { return }
        coredata.adicionar(encomendaParaSalvar)
        dispensarView()
    }
}

// MARK: - AdicionarEditarViewController

extension AdicionarEditarViewController: AdicionarEditarViewDelegate {
    func salvarEncomenda(_ encomenda: EncomendaParaAdicionarDTO) {
        self.encomendaParaSalvar = encomenda
    }

    func fecharCalendario() {
        dismiss(animated: true, completion: nil)
    }

    func habilitarBotaoSalvar(_ estaHabilitado: Bool) {
        salvarButtonItem.isEnabled = estaHabilitado
    }
}
