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

    do {
      try fetchResultController.performFetch()
    } catch {
      print("==44===:  error", error)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private

  private lazy var fetchResultController: NSFetchedResultsController<Encomenda> = {
    let fetchRequest: NSFetchRequest<Encomenda> = Encomenda.fetchRequest()

    let ordenador = NSSortDescriptor(key: #keyPath(Encomenda.adicionadoEm), ascending: false)
    fetchRequest.sortDescriptors = [ordenador]

    let nsfrc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                           managedObjectContext: GerenciadorCoreData.shared.contexto,
                                           sectionNameKeyPath: nil,
                                           cacheName: nil)
    nsfrc.delegate = self

    return nsfrc

  }()

  private lazy var listagemTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.accessibilityIdentifier = "listagem-tableView"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
}

// MARK: - PrincipalView

extension PrincipalView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    fetchResultController.sections?.count ?? 0
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let info = fetchResultController.sections?[section] else { return 0 }
    return info.numberOfObjects
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    let encomenda = fetchResultController.object(at: indexPath)

    var conteudo = cell.defaultContentConfiguration()
    conteudo.text = encomenda.codigo
    conteudo.secondaryText = encomenda.descricao


//    cell.textLabel?.text = encomenda.codigo
//    cell.detailTextLabel?.text = encomenda.descricao
//    cell.tex

    cell.contentConfiguration = conteudo
    return cell
  }

  private func configure() {
  }

  private func configurarConstraits() {
    NSLayoutConstraint.activate([
      listagemTableView.topAnchor.constraint(equalTo: topAnchor),
      listagemTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      listagemTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      listagemTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let apagarAction = UIContextualAction(style: .destructive, title: "Apagar") { acao, view, aoTerminar in
      let encomenda = self.fetchResultController.object(at: indexPath)
      GerenciadorCoreData.shared.contexto.delete(encomenda)
    }

    let config = UISwipeActionsConfiguration(actions: [apagarAction])
    return config
  }
}

// MARK: - PrincipalView

extension PrincipalView: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    listagemTableView.beginUpdates()
  }

  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      if let newIndexPath = newIndexPath {
        listagemTableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    case .delete:
      if let indexPath = indexPath {
        listagemTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    case .move:
      break
    case .update:
      if let indexPath = indexPath {
        listagemTableView.reloadRows(at: [indexPath], with: .automatic)
      }
    @unknown default:
      break
    }
  }

  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    listagemTableView.endUpdates()
  }
}
