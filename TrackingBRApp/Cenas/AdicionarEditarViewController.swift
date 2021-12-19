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
    init(coredata: CoreDataManager,
         encomendaSelecionada encomenda: Encomenda? = nil)
    {
        self.coredata = coredata
        self.encomendaSelecionada = encomenda
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()

        guard let encomenda = encomendaSelecionada else { return }
        addEditarView.configurar(encomenda)
    }

    // MARK: Internal
    override func loadView() {
        super.loadView()
        addEditarView.delegate = self
        view = addEditarView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Private
    private var viewModel = AdicionarEditarViewModel()

    private var coredata: CoreDataManager
    private lazy var addEditarView = AdicionarEditarView()

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

//    private var encomendaParaSalvar: EncomendaParaSalvarDTO?
    private var encomendaSelecionada: Encomenda?

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
        guard let encomendaParaSalvar = viewModel.encomenda else { return }
        coredata.adicionar(encomendaParaSalvar)

        dispensarView()
    }
}

// MARK: - AdicionarEditarViewDelegate
extension AdicionarEditarViewController: AdicionarEditarViewDelegate {
    func salvarEncomenda(_ encomenda: EncomendaParaSalvarDTO) {
        viewModel.salvar(encomenda)
    }

    func fecharCalendario() {
        dispensarView()
    }

    func habilitarBotaoSalvar(_ estaHabilitado: Bool) {
        salvarButtonItem.isEnabled = estaHabilitado
    }
}
