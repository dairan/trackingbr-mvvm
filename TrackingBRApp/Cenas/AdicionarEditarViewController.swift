//
//  AdicionarEditarViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

// MARK: - AdicionarEditarViewController

// protocol AdicionarEditarDelegate: AnyObject {
//  func salvarTappedTexto(texto: String)
// }

class AdicionarEditarViewController: UIViewController {
  // MARK: Internal

//  weak var delegate: AdicionarEditarDelegate?

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
    guard let encomenda = encomendaParaSalvar else { fatalError() }
    let encomendaCD = Encomenda(context: GerenciadorCoreData.shared.contexto)
    encomendaCD.codigo = encomenda.codigo
    encomendaCD.descricao = encomenda.descricao
    encomendaCD.adicionadoEm = encomenda.data

    do {
      try GerenciadorCoreData.shared.persistentContainer.viewContext.save()
    } catch {
      print("==19===:  error", error)
    }


    dispensarView()
  }

  private var encomendaParaSalvar: EncomendaParaSalvarDTO?
}

// MARK: - AdicionarEditarViewController

extension AdicionarEditarViewController: AdicionarEditarViewDelegate {
  func fecharView() {
    dismiss(animated: true, completion: nil)
  }


  func devolverEncomendaParaSalvar(encomenda: EncomendaParaSalvarDTO) {
    print("==32===:  encomenda", encomenda)
    encomendaParaSalvar = encomenda
  }

  
  func habilitarBotao(_ estaHabilitado: Bool) {
    salvarButtonItem.isEnabled = estaHabilitado
  }
}
