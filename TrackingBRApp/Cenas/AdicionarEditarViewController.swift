//
//  AdicionarEditarViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

// MARK: - AdicionarEditarDelegate

protocol AdicionarEditarDelegate: AnyObject {
  func salvarTappedTexto(texto: String)
}

// MARK: - AdicionarEditarViewController

class AdicionarEditarViewController: UIViewController {
  // MARK: Internal

  weak var delegate: AdicionarEditarDelegate?

  override func loadView() {
    super.loadView()
    let addEditarView = AdicionarEditarView()
    addEditarView.delegate = self
    view = addEditarView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navBarSetup()
  }

  // MARK: Private

  private func navBarSetup() {
    let cancelarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
    cancelarButtonItem.action = #selector(fecharTapped)

    let salvarButtonItem = UIBarButtonItem(systemItem: .save)
    salvarButtonItem.target = self
    salvarButtonItem.action = #selector(salvarTapped)

    navigationItem.leftBarButtonItem = cancelarButtonItem
    navigationItem.rightBarButtonItem = salvarButtonItem
  }

  private func fecharView() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func fecharTapped() {
    fecharView()
  }

  @objc private func salvarTapped() {
    fecharView()
  }
}

// MARK: AdicionarEditarViewDelegate

extension AdicionarEditarViewController: AdicionarEditarViewDelegate {
  func salvarTappedTexto(texto: String) {
    delegate?.salvarTappedTexto(texto: texto)
  }
}
