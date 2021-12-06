//
//  HeaderEncomendaTableViewCell.swift
//  TrackingBRApp
//
//  Created by Dairan on 29/09/21.
//

import UIKit

class DetalhesHeaderFooterView: UITableViewHeaderFooterView {
  // MARK: Lifecycle

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    configurar()
    configurarConstraits()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private lazy var codigoLabel: UILabel = {
    let label = UILabel()
    label.text = "Descrição do produto até duas linhas."
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private func configurar() {
    backgroundColor = .red
    contentView.backgroundColor = .systemOrange
    contentView.addSubview(codigoLabel)
  }

  private func configurarConstraits() {
    NSLayoutConstraint.activate([
      codigoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      codigoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}
