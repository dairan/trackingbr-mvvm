//
//  PrincipalView.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import UIKit

class PrincipalView: UIView {
  // MARK: Lifecycle

  init(viewModel: PrincipalViewModel) {
    super.init(frame: .zero)
    configurarUI()
    constraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private var viewModel: PrincipalViewModel? {
    didSet{
      label.text = viewModel?.titulo
    }
  }
  // MARK: Internal

  func configurar(com viewModel: PrincipalViewModel) {
    self.viewModel = viewModel
  }

  // MARK: Private

//  private let viewModel: PrincipalViewModel

  private lazy var label: DTFLabel = {
    let label = DTFLabel()
    return label
  }()

  private func configurarUI() {
    backgroundColor = .systemYellow
    addSubview(label)
  }

  private func constraints() {
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
