//
//  PrincipalView.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import CoreData
import UIKit

// MARK: - PrincipalView

class PrincipalView: UIView {
  // MARK: Lifecycle

  init() {
    super.init(frame: .zero)
    addSubview(listagemTableView)
    configurarConstraits()

    fonteDados = fonteDadosSetup()
    executarBuscaDadosCoreData()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private var fonteDados: UITableViewDiffableDataSource<String, Encomenda>?

  private lazy var fetchResultController: NSFetchedResultsController<Encomenda> = {
    let fetchRequest: NSFetchRequest<Encomenda> = Encomenda.fetchRequest()

    let ordenador = NSSortDescriptor(key: #keyPath(Encomenda.adicionadoEm), ascending: false)
    fetchRequest.sortDescriptors = [ordenador]

    let nsfrc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                           managedObjectContext: GerenciadorCoreData.shared.contexto,
                                           sectionNameKeyPath: nil,
                                           cacheName: "testeCache")
    nsfrc.delegate = self

    return nsfrc

  }()

  private lazy var listagemTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.accessibilityIdentifier = "listagem-tableView"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.delegate = self
    return tableView
  }()

  private func executarBuscaDadosCoreData() {
    do {
      try fetchResultController.performFetch()
    } catch {
      print("==44===:  error", error)
    }
  }

  private func fonteDadosSetup() -> UITableViewDiffableDataSource<String, Encomenda> {
    UITableViewDiffableDataSource(tableView: listagemTableView) { tableView, indexPath, itemIdentifier in
      let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
      let encomenda = self.fetchResultController.object(at: indexPath)

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

// MARK: - PrincipalView

extension PrincipalView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let encomenda = self.fetchResultController.object(at: indexPath)

    let apagarAction = UIContextualAction(style: .destructive, title: "Apagar") { acao, view, aoTerminar in
      GerenciadorCoreData.shared.contexto.delete(encomenda)
      aoTerminar(true)
    }
    apagarAction.image = UIImage(systemName: "trash")

    let editarButton = UIContextualAction(style: .normal, title: "Editar") { acao, view, aoTerminar in
      //         TODO: implementar edição do elemento.
      aoTerminar(true)
    }
    editarButton.backgroundColor = .systemOrange

    let config = UISwipeActionsConfiguration(actions: [apagarAction, editarButton])
    config.performsFirstActionWithFullSwipe = false

    return config
  }
}

// MARK: - PrincipalView

extension PrincipalView: NSFetchedResultsControllerDelegate {
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    var diferenca = NSDiffableDataSourceSnapshot<String, Encomenda>()
    diferenca.appendSections(["aa"])
    diferenca.appendItems(fetchResultController.fetchedObjects ?? [], toSection: nil)
    fonteDados?.apply(diferenca)
  }
}
