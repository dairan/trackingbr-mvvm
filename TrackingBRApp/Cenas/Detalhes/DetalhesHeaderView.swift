//
//  HeaderEncomendaTableViewCell.swift
//  TrackingBRApp
//
//  Created by Dairan on 29/09/21.
//

import UIKit

class DetalhesHeaderView: UITableViewHeaderFooterView {
    // MARK: Lifecycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configurarGeral()
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
}

// MARK: - ViewCode

extension DetalhesHeaderView: ViewCode {
    func configurar() {
        contentView.addSubview(codigoLabel)
    }

    func configurarView() {}

    func configurarConstraits() {
        NSLayoutConstraint.activate([
            codigoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            codigoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
