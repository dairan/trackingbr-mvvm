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

  private let salvarButtonItem = UIBarButtonItem(systemItem: .save)

  private func obterDados() {
    let repositorio = Repositorio()
    repositorio.verificar(aoTerminar: { resultado in
      switch resultado {
      case let .success(rastreio):
        print("==28===:  rastreio", rastreio ?? "")
      case let .failure(erro):
        print("==33===:  erro", erro)
      }
    })
  }

  private func navBarSetup() {
    let cancelarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                             target: self,
                                             action: nil)
    cancelarButtonItem.action = #selector(fecharDidTapped)

    salvarButtonItem.action = #selector(salvarTapped)
    salvarButtonItem.isEnabled = false
    salvarButtonItem.target = self

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

    dispensarView()
  }
}

// MARK: AdicionarEditarViewDelegate

extension AdicionarEditarViewController: AdicionarEditarViewDelegate {
  func devolveuEncomenda(_ encomenda: AdicionarEditar) {
    coredata.adicionar(encomenda)
  }

  func encontrouVariosCodigos(_ codigos: [String]) {
    codigosEncontrados = codigos
  }

  func fechouCalendario() {
    dismiss(animated: true, completion: nil)
  }

  func habilitouBotaoSalvar(_ estaHabilitado: Bool) {
    salvarButtonItem.isEnabled = estaHabilitado
  }
}
