//
//  AdicionarEditarView.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import Toast
import UIKit

// MARK: - AdicionarEditarViewDelegate

protocol AdicionarEditarViewDelegate: AnyObject {
  func devolveuEncomenda(_ encomenda: AdicionarEditar)
  func encontrouVariosCodigos(_ codigos: [String])
  func fechouCalendario()
  func habilitouBotaoSalvar(_ string: Bool)
}

// MARK: - AdicionarEditarView

class AdicionarEditarView: UIView {
  // MARK: Lifecycle

  required init? (coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(with viewModel: AdicionarEditarViewModelDelegate) {
    self.viewModel = viewModel
    super.init(frame: .zero)

    configurar()
    adicionarSubviews()
    configurarConstraits()
  }

  deinit {
    print("---------- deiniticializnado AdicionarEditarView ")
  }

  // MARK: Internal

  weak var delegate: AdicionarEditarViewDelegate?

  override func didAddSubview(_ subview: UIView) {
    print("1 - didAddSubview - view vai didMoveToWindow")
  }

  override func didMoveToWindow() {
    print("3 - AdicionarEditarView - view vai didMoveToWindow")
    colarCodigo()
  }

  override func willRemoveSubview(_ subview: UIView) {
    print("4 - AdicionarEditarView - view vai willRemoveSubview")
  }

  // MARK: Private

  private var encomenda = AdicionarEditar()

  private let viewModel: AdicionarEditarViewModelDelegate
  private var codigosEncontrados: [String] = []

  private lazy var textosStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 20

    return stackView
  }()

  private lazy var codigoTextField: MeuTextField = {
    let tf = MeuTextField().criar(comPlaceholder: "Código da encomenda", corBackground: .systemBackground)
    tf.delegate = self
    tf.autocapitalizationType = .allCharacters
    tf.smartInsertDeleteType = .no

    return tf
  }()

  private lazy var descricaoTextField: MeuTextField = {
    let tf = MeuTextField().criar(comPlaceholder: "Descrição", corBackground: .systemBackground)
    tf.delegate = self

    return tf
  }()

  private lazy var dataDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.preferredDatePickerStyle = .compact
    datePicker.datePickerMode = .date
    datePicker.tintColor = .white
    datePicker.minimumDate = Date()
    datePicker.addTarget(self, action: #selector(dataPickerMudouValor), for: .valueChanged)

    return datePicker
  }()

  private func validarRegex(_ codigo: String) -> Bool {
    let regexFormato = "([A-Z]{2})([0-9]{9})([A-Z]{2})"
    let range = NSRange(location: 0, length: codigo.utf16.count)
    let regex = try! NSRegularExpression(pattern: regexFormato, options: [.caseInsensitive, .allowCommentsAndWhitespace])
//    let resultado   codigo, options: [], range: range)
    var codigosUnicos: Set<String> = []

//    resultado.forEach { range in
//      let ra = range.range(at: 0)
//      if let swiftRange = Range(ra, in: codigo) {
//        let texto = codigo[swiftRange]
//        print("==20===:  texto", texto)
//        codigosUnicos.insert(String(texto))
//      }

//       let range1 = resultado.first
//       if let range2 = range1?.range(at: 0) {
//      if let swiftRange = Range(range2, in: codigo) {
//        let texto = codigo[swiftRange]
//        print("==11===:  texto", texto)
//      }
//    }

    if let resultado3 = codigo.range(of: #"([A-Z]{2})([0-9]{9})([A-Z]{2})"#, options: .regularExpression) {
      switch codigo[resultado3] {
      default:
        break
      }
    }
    return true
  }

  private func colarCodigo() {
    if let codigo = UIPasteboard.general.string?.trimmingCharacters(in: .whitespacesAndNewlines) {
      let resultado = validarRegex(codigo)
      switch resultado {
      case true:
        let toast = Toast.text("Código colado da área de transferência.")
        toast.show()
        delegate?.habilitouBotaoSalvar(true)
      case false:
        break
      }
    }
  }

  @objc private func dataPickerMudouValor(sender: UIDatePicker) {
    encomenda.data = sender.date
    delegate?.fechouCalendario()
  }

  private func configurar() {
    print("2 ++++ incializado \(type(of: self)) ")
    accessibilityIdentifier = "Adicionar-Editar-View"
    backgroundColor = .systemMint
  }

  private func adicionarSubviews() {
    addSubview(textosStackView)
    textosStackView.addArrangedSubview(codigoTextField)
    textosStackView.addArrangedSubview(descricaoTextField)
    textosStackView.addArrangedSubview(dataDatePicker)
  }

  private func configurarConstraits() {
    NSLayoutConstraint.activate([
      textosStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      textosStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
      textosStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
      textosStackView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0),

//      dataDatePicker.heightAnchor.constraint(equalToConstant: 40),
//      dataDatePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
//      dataDatePicker.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
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

// MARK: UITextFieldDelegate

extension AdicionarEditarView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case codigoTextField: descricaoTextField.becomeFirstResponder()
    default: descricaoTextField.resignFirstResponder()
    }
    return false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    switch textField {
    case codigoTextField:
      if let texto = textField.text {
        encomenda.codigo = texto
      }
    case descricaoTextField:
      if let texto = textField.text {
        encomenda.descricao = texto
      }
    default:
      break
    }
//    delegate?.devolveuEncomenda(encomenda)
  }

//  func textFieldDidChangeSelection(_ textField: UITextField) {
//    switch textField {
//      case codigoTextField:
//        if let codigo = textField.text {
//          encomendaParaSalvar.codigo = codigo
//        }
//      default:
//        if let descricao = textField.text {
//          encomendaParaSalvar.descricao = descricao
//        }
//    }
//  }

  /// para adcionar o texto field
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let textoAntigo = textField.text else { return false }
    guard let novoRange = Range(range, in: textoAntigo) else { return false }

//    let tamanho = textoAntigo.count + string.count - range.length
    let tamanho = textoAntigo.count + string.count - range.length
    let textoNovo = textoAntigo.replacingCharacters(in: novoRange, with: string)

    switch textField {
    case codigoTextField:

      delegate?.habilitouBotaoSalvar(tamanho > 12)

      guard tamanho <= 13 else {
        encomenda.codigo = textoAntigo
        descricaoTextField.becomeFirstResponder()
        delegate?.devolveuEncomenda(encomenda)
        return false
      }
      return true
    default:
      break
//      encomendaParaSalvar?.descricao = textoNovo
    }

    return true
  }

  private func validarTamanho() {
  }
}

// MARK: - MeuTextField



// MARK: - AdicionarEditarView + AdicionarEditarViewModelDelegate

//  // MARK: - EncomendaParaSalvarDTO
//
// extension AdicionarEditarView: UIPickerViewDataSource {
//  func numberOfComponents(in pickerView: UIPickerView) -> Int {
//    return 1
//  }
//
//  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//    return codigosEncontrados.count
//  }
// }
//
// extension AdicionarEditarView: UIPickerViewDelegate {
//  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    return codigosEncontrados[row]
//  }
//  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//  }
// }
