//
//  PrincipalViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import UIKit

// MARK: - PrincipalViewController

class PrincipalViewController: UIViewController {
  // MARK: Lifecycle

  init(com viewModel: PrincipalViewModel, e repositorio: Repositorio) {
    self.viewModel = viewModel
    self.repository = repositorio
    super.init(nibName: nil, bundle: nil)

    bind(viewModel)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()
    configurarNavBar()
  }

  override func loadView() {
    view = principalView
  }

  // MARK: Private

  private let viewModel: PrincipalViewModel
  private let repository: Repositorio

  private lazy var principalView: PrincipalView = {
    let view = PrincipalView(viewModel: self.viewModel)
    return view
  }()

  private func configurarNavBar() {
    let navButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(adicionarTapped))
    navigationItem.rightBarButtonItem = navButtonItem
    navigationItem.title = "Listagem"
  }

  @objc private func adicionarTapped() {
    let vc = AdicionarEditarViewController()
    vc.delegate = self
    vc.title = "Adicionar/ Editar"

    let nav = UINavigationController(rootViewController: vc)
    present(nav, animated: true)
  }

  private func bind(_ viewModel: PrincipalViewModel) {
    viewModel.atualizarView = {
      DispatchQueue.main.async {
        self.principalView.configurar(com: viewModel)
      }
    }
  }
}

// MARK: AdicionarEditarDelegate

extension PrincipalViewController: AdicionarEditarDelegate {
  func salvarTappedTexto(texto: String) {
    print(texto)
  }
}
