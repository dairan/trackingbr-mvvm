//
//  PrincipalView.swift
//  TrackingBR
//
//  Created by Dairan on 22/08/21.
//

import UIKit

class PrincipalView: UIView {
  // MARK: Lifecycle

  init(viewModel: PrincipalViewModel = PrincipalViewModel()) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    configurarUI()
    constraints()

    viewModel.rastreioResults.vincular { _ in
      DispatchQueue.main.async {
        self.label.text = viewModel.titulo
      }
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  func configurarUI() {
    backgroundColor = .systemYellow
    addSubview(label)
  }

  func constraints() {
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }

  // MARK: Private

  private let viewModel: PrincipalViewModel

  private lazy var label: DTFLabel = {
    let label = DTFLabel()
    label.text = viewModel.rastreioResults.valor?.type
    return label
  }()
}
