//
//  BaseViewController.swift
//  TrackingBRApp
//
//  Created by Dairan on 11/12/21.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Internal

    lazy var atividadeIndicador: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.center = self.view.center
        view.hidesWhenStopped = true
        return view
    }()

    // MARK: Private

    func atividadeIndicatorBegin() {
        view.addSubview(atividadeIndicador)
        atividadeIndicador.startAnimating()
    }

    func atividadeIndicatorEnd() {
        atividadeIndicador.stopAnimating()
    }
}
