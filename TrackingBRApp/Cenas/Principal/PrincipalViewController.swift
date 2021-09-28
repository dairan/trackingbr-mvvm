//
//  PrincipalViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

import UIKit

// MARK: - PrincipalViewController

class PrincipalViewController: UIViewController {
  // MARK: Lifecycle

  init(com viewModel: PrincipalViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(listagemTableView)
    configurarNavBar()
    configurarConstraits()
    bind(viewModel)
  }


  override func loadView() {
    view = principalView
  }

  // MARK: Private

  private lazy var listagemTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.accessibilityIdentifier = "Listagem TableView"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()

  private let viewModel: PrincipalViewModel
//  private let repositorio: Repositorio

  private lazy var principalView: PrincipalView = {
    let view = PrincipalView(viewModel: self.viewModel)
    return view
  }()

  private func configurarNavBar() {
    let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(adicionarTapped))
    navigationItem.rightBarButtonItem = addButtonItem
    navigationItem.title = "Listagem"

    let icone = UIImage(systemName: "gearshape.fill")!
    let configuracoesButtonItem = UIBarButtonItem(image: icone, style: .done, target: self, action: #selector(configuracoesTapped))
    navigationItem.leftBarButtonItem = configuracoesButtonItem
  }

  @objc private func adicionarTapped() {
    let vc = AdicionarEditarViewController()
//    vc.delegate = self
    vc.title = "Adicionar/ Editar"

    let nav = UINavigationController(rootViewController: vc)
    nav.navigationBar.tintColor = .white
    nav.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor : UIColor.white
    ]
    present(nav, animated: true)
  }

  @objc private func configuracoesTapped() {
    let vc = ConfiguracoesViewController()
    show(vc, sender: nil)
  }

  private func bind(_ viewModel: PrincipalViewModel) {
    viewModel.atualizarView = {
      DispatchQueue.main.async {
        self.principalView.configurar(com: viewModel)
      }
    }
  }

  private func configurarConstraits() {
    NSLayoutConstraint.activate([
      listagemTableView.topAnchor.constraint(equalTo: view.topAnchor),
      listagemTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      listagemTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      listagemTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

// MARK: - PrincipalViewController

// extension PrincipalViewController: AdicionarEditarDelegate {
//  func salvarTappedTexto(texto: String) {
//    print(texto)
//    let viewModel = PrincipalViewModel()
//    viewModel.titulo = texto
//    self.principalView.configurar(com: viewModel)
//  }
// }

extension PrincipalViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    return cell
  }
}
