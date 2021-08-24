//
//  PrincipalViewController.swift
//  TrackingBR
//
//  Created by Dairan on 22/08/21.
//

import UIKit

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

  private func bind(_ viewModel: PrincipalViewModel) {
    viewModel.atualizarView = { rastreio in
      DispatchQueue.main.async {
        self.principalView.configurar(com: rastreio)
      }
    }
  }
}
