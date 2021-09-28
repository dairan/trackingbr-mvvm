//
//  AdicionarEditarView.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

// MARK: - AdicionarEditarViewDelegate

protocol AdicionarEditarViewDelegate: AnyObject {
  func habilitarBotao(_ string: Bool)
  func devolverEncomendaParaSalvar(encomenda: EncomendaParaSalvarDTO)
  func fecharCalendario()
  func codigoParaSalvar(texto: String)
  func descricaoParaSalvar(texto: String)
  func dataParaSalvar(data: Date)
}

// MARK: - AdicionarEditarView

class AdicionarEditarView: UIView {
  // MARK: Lifecycle

  private var dataParaSalvar = Date()

  required init? (coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init() {
    super.init(frame: .zero)
    configurar()
    configurarConstraits()
  }

  // MARK: Internal

  weak var delegate: AdicionarEditarViewDelegate?

  // MARK: Private

  private var encomendaDTO = EncomendaParaSalvarDTO()
  private lazy var textFields: [MeuTextField] = [codigoTextField, descricaoTextField]

  private lazy var codigoTextField: MeuTextField = {
    let tf = MeuTextField().criar(comPlaceholder: "Código da encomenda", corBackground: .systemBackground)
    tf.delegate = self
    tf.tag = 0
    return tf
  }()

  private lazy var descricaoTextField: MeuTextField = {
    let tf = MeuTextField().criar(comPlaceholder: "Descrição", corBackground: .systemBackground)
    tf.delegate = self
    tf.tag = 1
    tf.spellCheckingType = .yes
    return tf
  }()

  private lazy var dataDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.tag = 2
    datePicker.datePickerMode = .date
    datePicker.tintColor = .white
    datePicker.minimumDate = Date()
    return datePicker
  }()

  private lazy var textosStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 20
    return stackView
  }()

  @objc private func dataPickerMudouValor(sender: UIDatePicker) {
    dataParaSalvar = sender.date
    delegate?.dataParaSalvar(data: dataParaSalvar)
    delegate?.fecharCalendario()
  }

  private func configurar() {
    backgroundColor = .systemMint

    addSubview(textosStackView)
    textFields.forEach { textosStackView.addArrangedSubview($0) }

    dataDatePicker.addTarget(self, action: #selector(dataPickerMudouValor), for: .valueChanged)
    textosStackView.addArrangedSubview(dataDatePicker)
  }

  private func configurarConstraits() {
    NSLayoutConstraint.activate([
      textosStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      textosStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
      textosStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
//      textosStackView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
      textosStackView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0),
    ])
  }
}

// MARK: - MeuTextField

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
  fileprivate func criar(comPlaceholder string: String, corBackground cor: UIColor) -> MeuTextField {
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

// MARK: - AdicionarEditarView + UITextFieldDelegate

extension AdicionarEditarView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    switch textField {
      case codigoTextField: descricaoTextField.becomeFirstResponder()
      default:
        descricaoTextField.resignFirstResponder()
        break
    }
    return false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
//    switch textField {
//    case let codigo where textField.tag == 0:
//      encomendaDTO.codigo = codigo.text ?? ""
//      delegate?.codigoParaSalvar(texto: codigo.text ?? "")
//    case let descricao where textField.tag == 1:
//      encomendaDTO.descricao = descricao.text ?? """"
//      delegate?.descricaoParaSalvar(texto: descricao.text ?? "")
//    default:
//      break
//    }

//    delegate?.devolverEncomendaParaSalvar(encomenda: encomendaDTO)
  }

  /// para adcionar o texto field
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let textoAntigo = textField.text else { return false }
    guard let novoRange = Range(range, in: textoAntigo) else { fatalError() }
    let textoNovo = textoAntigo.replacingCharacters(in: novoRange, with: string)

    let status = !textoNovo.isEmpty

    switch textField {
    case codigoTextField:
        let estaHabilitado = validar(se: textField, status)
        delegate?.habilitarBotao(estaHabilitado)
        delegate?.codigoParaSalvar(texto: textoNovo)
        delegate?.dataParaSalvar(data: dataParaSalvar)

    case descricaoTextField:
        delegate?.descricaoParaSalvar(texto: textoNovo)
    default: break
    }

    return true
  }

  private func validar(se textField: UITextField, _ temTexto: Bool) -> Bool {
    if temTexto {
      textField.layer.borderColor = UIColor.green.cgColor
      return true
    } else {
      textField.layer.borderColor = UIColor.red.cgColor
      return false
    }
  }
}
