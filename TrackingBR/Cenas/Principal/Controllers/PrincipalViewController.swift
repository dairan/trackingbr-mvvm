//
//  PrincipalViewController.swift
//  TrackingBR
//
//  Created by Dairan on 22/08/21.
//

import UIKit

class PrincipalViewController: UIViewController {
  // MARK: Lifecycle

  init(com viewModel: PrincipalViewModel = PrincipalViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func loadView() {
    view = principalView
  }

  // MARK: Private

  private let principalView: PrincipalView = {
    let view = PrincipalView()
    return view
  }()

  private let viewModel: PrincipalViewModel
}
