//
//  EncomendaDetalhesViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 29/09/21.
//

import UIKit

// MARK: - EncomendaDetalhesViewController

class EncomendaDetalhesViewController: UIViewController {
    // MARK: Lifecycle

    init(com viewModel: DetalhesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.encomenda.codigo

        configurar()
    }

    // MARK: Internal

    let viewModel: DetalhesViewModel
    var rastreio: Rastreio?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rastreioTableView.frame = view.bounds
    }

    // MARK: Private

    private lazy var rastreioTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetalhesHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderEncomenda")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EncomendaCellId")
        return tableView
    }()

    private func configurar() {
        view.backgroundColor = .yellow
        view.addSubview(rastreioTableView)
    }
}

// MARK: - UITableViewDataSource

extension EncomendaDetalhesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderEncomenda") as? DetalhesHeaderFooterView else {
            return UITableViewCell()
        }

        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rastreamento?.trackingEvents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rastreamento = viewModel.rastreamento?.trackingEvents?[indexPath.row] else { return UITableViewCell () }

        let cell = tableView.dequeueReusableCell(withIdentifier: "EncomendaCellId", for: indexPath)

        var conteudo = cell.defaultContentConfiguration()
        conteudo.text = rastreamento.eventDescription
        conteudo.secondaryText = rastreamento.eventLocation

        cell.contentConfiguration = conteudo
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EncomendaDetalhesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150
    }
}
