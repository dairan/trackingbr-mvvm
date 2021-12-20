//
//  PrincipalTableViewCell.swift
//  TrackingBRApp
//
//  Created by Dairan on 19/12/21.
//

import UIKit

class PrincipalTableViewCell: UITableViewCell {
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurarView()
        adicionarConstrais()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal
    static let CellID = "PrincipalTableViewCell"

    func configurar(_ encomenda: Encomenda) {
        self.codigoLabel.text = encomenda.codigo
        self.descricaoLabel.text = encomenda.descricao
        self.dataLabel.text = encomenda.adicionadoEm?.formatted()
    }

    // MARK: Private
    private lazy var cellStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .equalCentering
        view.spacing = 6
        return view
    }()

    private let codigoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "teste1"
        return label
    }()

    private let descricaoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "descriao da encomenda"
        return label
    }()

    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.text = "22/03/2021"
        return label
    }()

    private func configurarView() {
        cellStackView.addArrangedSubview(codigoLabel)
        cellStackView.addArrangedSubview(descricaoLabel)
        cellStackView.addArrangedSubview(dataLabel)
        contentView.addSubview(cellStackView)
    }

    private func adicionarConstrais() {
        let guia = contentView.readableContentGuide
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: guia.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: guia.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: guia.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: guia.bottomAnchor),
        ])
    }
}
