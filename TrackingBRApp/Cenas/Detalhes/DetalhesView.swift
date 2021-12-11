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
        configurarView()
    }

    // MARK: Private

    private var viewModel: DetalhesViewModel?

    private lazy var rastreioTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetalhesHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderEncomenda")
        tableView.register(DetalheCell.self, forCellReuseIdentifier: DetalheCell.identificador)
        return tableView
    }()
}

// MARK: - ViewCode

extension DetalhesView: ViewCode {
    func configurar() {}

    func configurarConstraits() {}

    func configurarView() {
        addSubview(rastreioTableView)
        rastreioTableView.frame = bounds
    }
}

// MARK: - UITableViewDataSource

extension DetalhesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderEncomenda") as? DetalhesHeaderView else {
            return UITableViewCell()
        }
        return view
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let minhaView = view as? DetalhesHeaderView else { return }
        minhaView.contentView.backgroundColor = .systemMint
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rastreamento?.trackingEvents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rastreamento = viewModel?.rastreamento?.trackingEvents?[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: DetalheCell.identificador, for: indexPath) as! DetalheCell
        cell.configurar(com: rastreamento)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetalhesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        120
    }
}
