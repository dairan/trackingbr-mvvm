//
//  DetalhesView.swift
//  TrackingBRApp
//
//  Created by Dairan on 10/12/21.
//

import UIKit

class DetalhesView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(rastreioTableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(viewModel: DetalhesViewModel) {
        self.init(frame: .zero)
        self.viewModel = viewModel
    }

    // MARK: Internal

    override func layoutSubviews() {
        super.layoutSubviews()
        rastreioTableView.frame = bounds
    }

    // MARK: Private

    private var viewModel: DetalhesViewModel?

    private lazy var rastreioTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetalhesHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderEncomenda")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EncomendaCellId")
        return tableView
    }()
}

// MARK: - UITableViewDataSource

extension DetalhesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderEncomenda") as? DetalhesHeaderView else {
            return UITableViewCell()
        }
        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rastreamento?.trackingEvents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rastreamento = viewModel?.rastreamento?.trackingEvents?[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "EncomendaCellId", for: indexPath)

        var conteudo = cell.defaultContentConfiguration()
        conteudo.text = rastreamento.eventDescription
        conteudo.secondaryText = rastreamento.eventLocation

        cell.contentConfiguration = conteudo
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetalhesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
}
