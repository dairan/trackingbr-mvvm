//
//  PrincipalView.swift
//  TrackingBR
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

//    viewModel.rastreioResults.vincular { _ in
//      DispatchQueue.main.async {
//        self.label.text = viewModel.titulo
//      }
//    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private var rastreio: Rastreio? {
    didSet{
      label.text = rastreio?.postedAt
    }
  }
  // MARK: Internal

  func configurar(com rastreio: Rastreio) {
    self.rastreio = rastreio
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
