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

  init(encomenda: Encomenda) {
    self.encomenda = encomenda
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let encomenda: Encomenda
  var rastreio: Rastreio?

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.prefersLargeTitles = true

    title = encomenda.codigo

    configurar()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
//    Repositorio().verificar { resultado in
//      switch resultado  {
//
//        case .success(let rastreio):
//          self.rastreio = rastreio!
//          DispatchQueue.main.async {
//            self.rastreioTableView.reloadData()
//          }
//        case .failure(let erro):
//          print("==30===:  erro", erro)
//      }
//    }
  }

  // MARK: Private

  private lazy var rastreioTableView: UITableView = {
    let tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
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

// MARK: - EncomendaDetalhesViewController

extension EncomendaDetalhesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderEncomenda") as! DetalhesHeaderFooterView

    return view
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 100
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    rastreio?.tracks.count ?? 0
      0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EncomendaCellId", for: indexPath)

    var conteudo = cell.defaultContentConfiguration()
//    conteudo.text = rastreio?.tracks[indexPath.row].locale

    cell.contentConfiguration = conteudo
    return cell
  }
}

// MARK: - EncomendaDetalhesViewController

extension EncomendaDetalhesViewController: UITableViewDelegate {

}
