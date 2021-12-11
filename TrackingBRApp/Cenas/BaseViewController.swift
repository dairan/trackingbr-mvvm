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

    func atividadeIndicatorBegin() {
        guard let janelaAtual = UIApplication.shared.atualUIWindow() else { return }
        janelaAtual.addSubview(bgView)

        bgView.addSubview(atividadeIndicador)
        bgView.animar()

        atividadeIndicador.startAnimating()

    }

    func atividadeIndicatorEnd() {
        atividadeIndicador.stopAnimating()
        bgView.alpha = 0.0
        bgView.removeFromSuperview()
    }

        // MARK: Private

    private lazy var atividadeIndicador: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.center = self.view.center
        view.color = .systemOrange
        view.hidesWhenStopped = true
        return view
    }()

    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.frame = self.view.bounds
        view.alpha = 0.0
        return view
    }()
}

extension UIView {
    func animar() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0.75
        }
    }
}

extension UIApplication {
    func atualUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter {
                $0.activationState == .foregroundActive
            }
            .compactMap { $0 as? UIWindowScene }

        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}
