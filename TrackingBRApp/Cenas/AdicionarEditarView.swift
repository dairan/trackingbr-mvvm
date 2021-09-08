//
//  AdicionarEditarView.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

protocol AdicionarEditarViewDelegate: AnyObject {
  func salvarTappedTexto(texto: String)
}


class AdicionarEditarView: UIView {
  // MARK: Lifecycle

  weak var delegate: AdicionarEditarViewDelegate?


  init() {
    super.init(frame: .zero)
    configurar()
    configurarConstraits()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: Private

  private func configurar() {
    backgroundColor = .systemGreen

    addSubview(textosStackView)
    let views: [UIView] = [tf1, tf2, tf3, codigoTextField]
    for view in views {
      textosStackView.addArrangedSubview(view)
//      view.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
  }

  private lazy var tf1: UITextField = { criarTextField(com: "tf1", e: .lightGray) }()
  private lazy var tf2: UITextField = { criarTextField(com: "tf2", e: .lightGray) }()
  private lazy var tf3: UITextField = { criarTextField(com: "tf3", e: .lightGray) }()
  private lazy var codigoTextField: UITextField = { criarTextField(com: "codigo text field", e: .lightGray) }()

  private lazy var textosStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
//    stackView.alignment = .fill
    stackView.backgroundColor = .magenta
    stackView.spacing = 20
//    stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    stackView.isLayoutMarginsRelativeArrangement = true

    return stackView
  }()

  private func configurarConstraits() {
    NSLayoutConstraint.activate([
      textosStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      textosStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
//      textosStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
      textosStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 2),

//      textosStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      textosStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
    ])
  }
}

extension AdicionarEditarView: TextFieldFactory {
  internal func criarTextField(com placeholder: String, e cor: UIColor) -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeholder
    textField.backgroundColor = cor
    textField.delegate = self
    textField.setContentHuggingPriority(UILayoutPriority(300), for: .vertical)
    return textField
  }
}

extension AdicionarEditarView: AdicionarEditarViewDelegate {
  func salvarTappedTexto(texto: String) {

  }
}

extension AdicionarEditarView: UITextFieldDelegate {

  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let texto = textField.text else { return }
    delegate?.salvarTappedTexto(texto: texto)
  }
}
