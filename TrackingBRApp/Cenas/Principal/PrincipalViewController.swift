//
//  PrincipalViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 22/08/21.
//

//import CoreData
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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configurarNavBar()


  }

  override func loadView() {
    view = principalView
  }


  private let viewModel: PrincipalViewModel

  private lazy var principalView: PrincipalView = {
    let view = PrincipalView()
    return view
  }()

  private func configurarNavBar() {
    let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(adicionarTapped))
    navigationItem.rightBarButtonItem = addButtonItem
    navigationItem.title = "Listagem"

    let icone = UIImage(systemName: "gearshape.fill")!
    let configuracoesButtonItem = UIBarButtonItem(image: icone,
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(configuracoesTapped))
    navigationItem.leftBarButtonItem = configuracoesButtonItem
  }

  @objc private func adicionarTapped() {
    let vc = AdicionarEditarViewController()
    vc.title = "Adicionar/ Editar"

    let nav = UINavigationController(rootViewController: vc)
    nav.navigationBar.tintColor = .white
    nav.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
    ]
    present(nav, animated: true)
  }

  @objc private func configuracoesTapped() {
    let vc = ConfiguracoesViewController()
    showDetailViewController(vc, sender: nil)
  }


}

