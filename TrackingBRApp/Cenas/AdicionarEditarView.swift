//
//  AdicionarEditarView.swift
//  TrackingBRApp
//
//  Created by Dairan on 07/09/21.
//

import UIKit

// MARK: - AdicionarEditarViewDelegate

protocol AdicionarEditarViewDelegate: AnyObject {
    func salvarEncomenda(_ encomenda: EncomendaParaSalvarDTO)
    func fecharCalendario()
    func habilitarBotaoSalvar(_ string: Bool)
}

// MARK: - AdicionarEditarView

class AdicionarEditarView: UIView {
    // MARK: Lifecycle
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
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
    var encomenda = EncomendaParaSalvarDTO()

    func configurar(_ encomenda: Encomenda) {
        codigoTextField.text = encomenda.codigo
        descricaoTextField.text = encomenda.descricao
    }

//    override func didMoveToWindow() {
//        colarCodigo()
//    }

    // MARK: Private
    private lazy var codigoTextField: DTFTextField = {
        let textField = DTFTextField(self, com: "Código", fundoNa: .systemBackground)
        textField.autocapitalizationType = .allCharacters
        textField.smartInsertDeleteType = .no
        textField.clearButtonMode = .whileEditing
        return textField
    }()

    private lazy var descricaoTextField: DTFTextField = {
        let textField = DTFTextField(self, com: "Descrição", fundoNa: .systemBackground)
        return textField
    }()

    private lazy var dateDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.tintColor = .systemTeal
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self,
                             action: #selector(dataPickerMudouValor),
                             for: .valueChanged)
        return datePicker
    }()

    private lazy var textosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

//    private func validarRegex(_ codigo: String) -> Bool {
//        if let resultado3 = codigo.range(of: #"([A-Z]{2})([0-9]{9})([A-Z]{2})"#, options: .regularExpression) {
//            switch codigo[resultado3] {
//                default: break
//            }
//        }
//        return true
//    }

//    private let validar = Validacao()

//    private func colarCodigo() {
//        if let codigo = UIPasteboard.general.string?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            let resultado = validarRegex(codigo)
//            delegate?.habilitarBotaoSalvar(resultado)
//            switch resultado {
//                case true:
//                    let toast = Toast.text("Código colado da área de transferência.")
//                    toast.show()
//                    codigoTextField.text = codigo
//                case false:
//                    break
//            }
//        }
//    }

    @objc private func dataPickerMudouValor(sender: UIDatePicker) {
        encomenda.data = sender.date
        delegate?.fecharCalendario()
    }

    private func configurar() {
        accessibilityIdentifier = "AdicionarEditarView"
        backgroundColor = .systemMint
        codigoTextField.becomeFirstResponder()
    }

    private func adicionarSubviews() {
        addSubview(textosStackView)
        textosStackView.addArrangedSubview(codigoTextField)
        textosStackView.addArrangedSubview(descricaoTextField)
        textosStackView.addArrangedSubview(dateDatePicker)
    }

    private func configurarConstraits() {
        NSLayoutConstraint.activate([
            textosStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            textosStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textosStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            textosStackView.bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0),
        ])
    }

    private func coresTextField(ehValido: Bool) {
        guard ehValido else {
            codigoTextField.layer.borderColor = UIColor.systemRed.cgColor
            codigoTextField.layer.borderWidth = 1.0
            return
        }

        codigoTextField.layer.borderColor = .none
        codigoTextField.layer.borderWidth = 0.0
    }
}

// MARK: - UITextFieldDelegate
extension AdicionarEditarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case codigoTextField:
                codigoTextField.layer.borderWidth = 1.0
                codigoTextField.layer.borderColor = UIColor.red.cgColor
            default: descricaoTextField.resignFirstResponder()
        }
        return false
    }

//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        switch textField {
//            case codigoTextField:
//                guard let texto = textField.text else { return true }
//                if texto.count > 13 {
//                    return false
//                }
//            default:
//                return true
//        }
//        return true
//    }

//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        guard let texto = textField.text else { return false }
//
//        switch textField {
//            case codigoTextField:
//                guard texto.count <= 13 else { return false }
//                return true
//            case descricaoTextField:
//                return true
//            default:
//                return false
//        }
//    }

//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        guard let texto = textField.text else { return false }
//        switch textField {
//
//            case codigoTextField:
//                return true
//            case descricaoTextField:
//                return true
//            default:
//                return false
//        }
//        switch textField {
//            case codigoTextField:
    ////                encomenda.codigo = texto
    ////                delegate?.salvarEncomenda(encomenda)
//                return true
//            case descricaoTextField:
    ////                encomenda.descricao = texto
//                return true
//            default:
//                return false
    ////        }
//    }

//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        switch textField {
//            case codigoTextField:
//                if let codigo = textField.text {
//                    if codigo.count != 13 {
//                        textField.layer.borderColor = UIColor.systemRed.cgColor
//                        textField.layer.borderWidth = 1.0
//                    } else {
//                        textField.layer.borderColor = .none
//                        textField.layer.borderWidth = 0.0
//                        encomenda.codigo = codigo
//                    }
//                }
//            default:
//                if let descricao = textField.text {
//                    encomenda.descricao = descricao
//                }
//        }
//    }

    private func removerBackspace(_ string: String, _ validacao: Bool, _ textField: UITextField) {
        if let char = string.cString(using: String.Encoding.utf8) {
            let ehBackspace = strcmp(char, "\\b")
            if ehBackspace == -92, validacao {
                textField.text?.removeLast()
            }
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let texto = textField.text else { return }
        switch textField {
            case codigoTextField:
                let ehCodigoValido = Validacao.validarRegex(texto)
                coresTextField(ehValido: ehCodigoValido)
                delegate?.habilitarBotaoSalvar(ehCodigoValido)
                return
            default:
                return
        }
    }

    /// para adcionar o texto field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textoAntigo = textField.text else { return false }
        guard let novoRange = Range(range, in: textoAntigo) else { return false }

        let tamanho = textoAntigo.count + string.count - range.length
        let textoNovo = textoAntigo.replacingCharacters(in: novoRange, with: string)

        switch textField {
            case codigoTextField:

                let ehCodigoValido = Validacao.validarRegex(textoNovo)
                coresTextField(ehValido: ehCodigoValido)
                delegate?.habilitarBotaoSalvar(ehCodigoValido)

                guard ehCodigoValido else { return true }

                encomenda.codigo = textoNovo
                textField.text = textoNovo

                descricaoTextField.becomeFirstResponder()
                delegate?.salvarEncomenda(encomenda)
                return false
            default:
                encomenda.descricao = textoNovo
                delegate?.salvarEncomenda(encomenda)
                return true
        }
    }
}

//extension UITextField {
//    func removeBackspace(string: String, _ validacao: Bool) {
//        guard let char = string.cString(using: String.Encoding.utf8) else { return }
//        let ehBackspace = strcmp(char, "\\b")
//        if ehBackspace == -92, validacao {
//            self.text?.removeLast()
//        }
//    }
//}
