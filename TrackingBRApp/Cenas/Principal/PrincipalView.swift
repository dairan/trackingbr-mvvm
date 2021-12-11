//
//  PrincipalView.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import CoreData
import UIKit

// MARK: - PrincipalViewDelegate

protocol PrincipalViewDelegate: AnyObject {
    func encomendaSelecionada(_ encomenda: Encomenda)
    func editarSelecionada(_ encomenda: Encomenda)
    func selecionouRowAt(_ indexPath: IndexPath)
}

// MARK: - PrincipalView

class PrincipalView: UIView {
    // MARK: Lifecycle

    init(coredata: CoreDataManager) {
        self.coredata = coredata
        super.init(frame: .zero)

        addSubview(listagemTableView)
        configurarConstraits()

        fonteDados = fonteDadosSetup()
        executarBuscaDadosCoreData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    weak var delegate: PrincipalViewDelegate?

    // MARK: Private

    private var coredata: CoreDataManager
    private var fonteDados: UITableViewDiffableDataSource<String, Encomenda>?

    private lazy var listagemTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "listagem-tableView"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.delegate = self
        return tableView
    }()

    private func executarBuscaDadosCoreData() {
        coredata.fetchResultController.delegate = self
        do {
            try coredata.fetchResultController.performFetch()
        } catch {
            print("==44===:  error", error)
        }
    }

    private func fonteDadosSetup() -> UITableViewDiffableDataSource<String, Encomenda> {
        UITableViewDiffableDataSource(tableView: listagemTableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
            let encomenda = self.coredata.fetchResultController.object(at: indexPath)

            var conteudo = cell.defaultContentConfiguration()
            conteudo.text = encomenda.codigo
            conteudo.secondaryText = encomenda.descricao

            cell.contentConfiguration = conteudo

            return cell
        }
    }

    private func configurarConstraits() {
        NSLayoutConstraint.activate([
            listagemTableView.topAnchor.constraint(equalTo: topAnchor),
            listagemTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listagemTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listagemTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate

extension PrincipalView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let encomenda = coredata.fetchResultController.object(at: indexPath)
        delegate?.encomendaSelecionada(encomenda)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let encomenda = coredata.fetchResultController.object(at: indexPath)

        let apagarAction = UIContextualAction(style: .destructive, title: "Apagar") { acao, view, aoTerminar in
            self.coredata.apagar(encomenda: encomenda)
            aoTerminar(true)
        }
        apagarAction.image = UIImage(systemName: "trash")

        let editarButton = UIContextualAction(style: .normal, title: "Editar") { acao, view, aoTerminar in
            aoTerminar(true)
        }
        editarButton.backgroundColor = .systemOrange

        let config = UISwipeActionsConfiguration(actions: [apagarAction, editarButton])
        config.performsFirstActionWithFullSwipe = false

        return config
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension PrincipalView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference)
    {
        var diferenca = NSDiffableDataSourceSnapshot<String, Encomenda>()
        diferenca.appendSections(["aa"])
        diferenca.appendItems(coredata.fetchResultController.fetchedObjects ?? [], toSection: nil)
        fonteDados?.apply(diferenca)
    }
}
