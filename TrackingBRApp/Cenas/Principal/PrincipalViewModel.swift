//
//  PrincipalViewModel.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import Foundation
import CoreData

// MARK: - PrincipalViewModel

class PrincipalViewModel {
    // MARK: Lifecycle

    init(coreData: CoreDataManager, repositorio: Repositorio) {
        self.coreData = coreData
        self.repositorio = repositorio
//        buscarCoreData()
//    obterDados()
    }


    // MARK: Internal

    var atualizarView: (() -> Void)?
    var rastreio: Rastreio? { didSet { atualizarView?() } }
    var encomendas: [Encomenda]?

    private(set) var encomendaSelecionada: Encomenda?

//    var numeroDeRows: Int {
//        coreData.fetchResultController
//    }


    func selecionar(encomendaNo indexPath: IndexPath) -> Encomenda {
        coreData.fetchResultController.object(at: indexPath)
    }

    func apagar(encomenda: Encomenda) {
        coreData.apagar(encomenda: encomenda)
    }

//    var fonteDados: UITableViewDiffableDataSource<String, Encomenda> = {
//        let fonteDados = UITableViewDiffableDataSource<String, Encomenda>
//        fonteDados.
//    }()
//    // MARK: Private

//    private var fonteDados: UITableViewDiffableDataSource<String, Encomenda>?


//    private func fonteDadosSetup() -> UITableViewDiffableDataSource<String, Encomenda> {
//        UITableViewDiffableDataSource(tableView: listagemTableView) { tableView, indexPath, itemIdentifier in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
//
//            let encomenda = self.viewModel.selecionar(encomendaNo: indexPath)
//
//            var conteudo = cell.defaultContentConfiguration()
//            conteudo.text = encomenda.codigo
//            conteudo.secondaryText = encomenda.descricao
//
//            cell.contentConfiguration = conteudo
//
//            return cell
//        }
//    }

    private var repositorio: Repositorio
    private var coreData: CoreDataManager

    private func obterDados() {
//    repositorio.verificar(aoTerminar: { resultado in
//      switch resultado {
//      case let .success(rastreio):
//        print("==28===:  rastreio", rastreio)
//          break
//      case let .failure(erro):
//        print("==33===:  erro", erro)
//      }
//    })
    }
}


    // MARK: - NSFetchedResultsControllerDelegate

//extension PrincipalViewModel: NSFetchedResultsControllerDelegate {
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
//                    didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference)
//    {
//    var diferenca = NSDiffableDataSourceSnapshot<String, Encomenda>()
//    diferenca.appendSections(["aa"])
//    diferenca.appendItems(viewModel.encomendas, toSection: nil)
//    fonteDados?.apply(diferenca)
//    }
//}
