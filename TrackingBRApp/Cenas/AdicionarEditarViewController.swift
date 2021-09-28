//
//  AdicionarEditarViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

// MARK: - AdicionarEditarViewController

class AdicionarEditarViewController: UIViewController {
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

  // MARK: Private

  private var encomendaParaSalvar = EncomendaParaSalvarDTO()

  private let viewModel = AdicionarEditarViewModel()
  private lazy var addEditarView = AdicionarEditarView()
  private let salvarButtonItem = UIBarButtonItem(systemItem: .save)


  private func navBarSetup() {
    let cancelarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                             target: self,
                                             action: nil)
    cancelarButtonItem.action = #selector(fecharDidTapped)

    salvarButtonItem.target = self
    salvarButtonItem.action = #selector(salvarTapped)
    salvarButtonItem.isEnabled = false

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

    guard !encomendaParaSalvar.codigo.isEmpty else { return }

    let encomendaCD = Encomenda(context: GerenciadorCoreData.shared.contexto)
    encomendaCD.codigo = encomendaParaSalvar.codigo
    encomendaCD.descricao = encomendaParaSalvar.descricao
    encomendaCD.adicionadoEm = encomendaParaSalvar.data

    do {
      try GerenciadorCoreData.shared.persistentContainer.viewContext.save()
    } catch {
      print("==19===:  error", error)
    }

    dispensarView()
  }
}

// MARK: - AdicionarEditarViewController

extension AdicionarEditarViewController: AdicionarEditarViewDelegate {
  func codigoParaSalvar(texto: String) {
    encomendaParaSalvar.codigo = texto
  }

  func descricaoParaSalvar(texto: String) {
    encomendaParaSalvar.descricao = texto

  }

  func dataParaSalvar(data: Date) {
    encomendaParaSalvar.data = data

  }

  func fecharCalendario() {
    dismiss(animated: true, completion: nil)
  }

  func devolverEncomendaParaSalvar(encomenda: EncomendaParaSalvarDTO) {
    print("==32===:  encomenda", encomenda)
//    encomendaParaSalvar = encomenda
  }

  func habilitarBotao(_ estaHabilitado: Bool) {
    salvarButtonItem.isEnabled = estaHabilitado
  }
}

// MARK: - EncomendaParaSalvarDTO

struct EncomendaParaSalvarDTO {
  var codigo: String = ""
  var descricao: String = ""
  var data = Date()
}
