//
//  DetalheCell.swift
//  TrackingBRApp
//
//  Created by Dairan on 11/12/21.
//

import UIKit

class DetalheCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurarGeral()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    static let identificador = "DetalheCell"

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configurar(com rastreamento: TrackingEvent) {
        dataLabel.text = rastreamento.eventDateTime.formatted()
        localLabel.text = rastreamento.eventLocation
        descricaoLabel.text = rastreamento.eventDescription
    }

    // MARK: Private

    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        stackView.accessibilityIdentifier = "info-StackView"
        return stackView
    }()

    private let dataLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "data-Label"
        return label
    }()

    private let localLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "local-Label"
        return label
    }()

    private let descricaoLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.accessibilityIdentifier = "descricao-Label"
        return label
    }()
}

// MARK: - ViewCode

extension DetalheCell: ViewCode {
    func configurar() {}

    func configurarConstraits() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func configurarView() {
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(dataLabel)
        infoStackView.addArrangedSubview(localLabel)
        infoStackView.addArrangedSubview(descricaoLabel)
    }
}
