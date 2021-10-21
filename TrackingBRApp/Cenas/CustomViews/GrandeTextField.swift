//
//  GrandeTextField.swift
//  TrackingBRApp
//
//  Created by Dairan on 21/10/21.
//

import UIKit

class MeuTextField: UITextField {
  // MARK: Internal

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: espacamento)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    bounds.inset(by: espacamento)
  }

  // MARK: Fileprivate

  /// Para criar TextFields
  /// - Parameters:
  ///   - string: texto do placeholder
  ///   - cor: de background
  /// - Returns: textField montado pronto para uso.
  func criar(comPlaceholder string: String, corBackground cor: UIColor) -> MeuTextField {
    let textField = MeuTextField(frame: .zero)
    textField.accessibilityIdentifier = string
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = string
    textField.backgroundColor = cor
    textField.layer.cornerRadius = espacamento.top / 2
    textField.layer.borderWidth = 1
    textField.font = UIFont.preferredFont(forTextStyle: .title1)
    textField.layer.borderColor = UIColor.white.cgColor
    textField.layer.masksToBounds = true
    textField.autocorrectionType = .no
    textField.enablesReturnKeyAutomatically = true
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    return textField
  }

  // MARK: Private

  private let espacamento = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
}
