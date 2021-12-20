//
//  DTFTextField.swift
//  TrackingBRApp
//
//  Created by Dairan on 21/10/21.
//

import UIKit

//protocol DTFTextFieldDelegate {
//    func textFieldPressionado()
//}

class DTFTextField: UITextField {
    // MARK: Lifecycle
    init(_ delegate: UITextFieldDelegate, com titulo: String, fundoNa cor: UIColor) {
        super.init(frame: .zero)
        accessibilityIdentifier = titulo
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = titulo
        backgroundColor = cor
        layer.cornerRadius = espacamento.top / 2
        layer.borderWidth = 1
        font = UIFont.preferredFont(forTextStyle: .title1)
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        autocorrectionType = .no
        enablesReturnKeyAutomatically = true
        autocapitalizationType = .none
        autocorrectionType = .no
        spellCheckingType = .no
        self.delegate = delegate
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Internal
    override func textRect(forBounds bounds: CGRect) -> CGRect { bounds.inset(by: espacamento) }
    override func editingRect(forBounds bounds: CGRect) -> CGRect { bounds.inset(by: espacamento) }

    // MARK: Private
    private let espacamento = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
}
