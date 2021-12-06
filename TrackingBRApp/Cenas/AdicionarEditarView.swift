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

    override func didAddSubview(_ subview: UIView) {
//        print("1 - didAddSubview - view vai didMoveToWindow")
    }

    func configurar(_ encomenda: Encomenda) {
        codigoTextField.text = encomenda.codigo
        codigoTextField.isEnabled = false
        descricaoTextField.text = encomenda.descricao
    }

    override func didMoveToWindow() {
        colarCodigo()
    }

    override func willRemoveSubview(_ subview: UIView) {
//        print("4 - AdicionarEditarView - view vai willRemoveSubview")
    }

    // MARK: Private

    private lazy var textosStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20

        return stackView
    }()

    private lazy var codigoTextField: MeuTextField = {
        let textField = MeuTextField().criar(comPlaceholder: "Código da encomenda", corBackground: .systemBackground)
        textField.delegate = self
        textField.autocapitalizationType = .allCharacters
        textField.smartInsertDeleteType = .no
        textField.clearButtonMode = .whileEditing

        return textField
    }()

    private lazy var descricaoTextField: MeuTextField = {
        let textField = MeuTextField().criar(comPlaceholder: "Descrição", corBackground: .systemBackground)
        textField.delegate = self

        return textField
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
        if let resultado3 = codigo.range(of: #"([A-Z]{2})([0-9]{9})([A-Z]{2})"#, options: .regularExpression) {
            switch codigo[resultado3] {
                default: break
            }
        }
        return true
    }

    private func colarCodigo() {
        if let codigo = UIPasteboard.general.string?.trimmingCharacters(in: .whitespacesAndNewlines) {
            let resultado = validarRegex(codigo)
            delegate?.habilitarBotaoSalvar(resultado)
            switch resultado {
                case true:
                    let toast = Toast.text("Código colado da área de transferência.")
                    toast.show()
                    codigoTextField.text = codigo
                case false:
                    break
            }
        }
    }

    @objc private func dataPickerMudouValor(sender: UIDatePicker) {
        encomenda.data = sender.date
        delegate?.fecharCalendario()
    }

    private func configurar() {
        accessibilityIdentifier = "Adicionar-Editar-View"
        backgroundColor = .systemMint
        codigoTextField.becomeFirstResponder()
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
        ])
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("==56===:  textFieldDidBeginEditing", textFieldDidBeginEditing)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let texto = textField.text else { return false }
        switch textField {
            case codigoTextField:
                encomenda.codigo = texto
                delegate?.salvarEncomenda(encomenda)
                return true
            case descricaoTextField:
                encomenda.descricao = texto
                return true
            default:
                return false
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
            case codigoTextField:
                if let codigo = textField.text {
                    if codigo.count != 13 {
                        textField.layer.borderColor = UIColor.systemRed.cgColor
                        textField.layer.borderWidth = 1.0
                    } else {
                        textField.layer.borderColor = .none
                        textField.layer.borderWidth = 0.0
                        encomenda.codigo = codigo
                    }
                }
            default:
                if let descricao = textField.text {
                    encomenda.descricao = descricao
                }
        }
    }

    /// para adcionar o texto field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textoAntigo = textField.text else { return false }
        guard let novoRange = Range(range, in: textoAntigo) else { return false }

        let tamanho = textoAntigo.count + string.count - range.length
        let textoNovo = textoAntigo.replacingCharacters(in: novoRange, with: string)

        let validacao = tamanho == 13

        switch textField {
            case codigoTextField:
                if let char = string.cString(using: String.Encoding.utf8) {
                    let ehBackspace = strcmp(char, "\\b")
                    if ehBackspace == -92, validacao {
                        textField.text?.removeLast()
                    }
                }

                delegate?.habilitarBotaoSalvar(validacao)
                delegate?.salvarEncomenda(encomenda)

                guard validacao else { return true }

                textField.text = textoNovo

                descricaoTextField.becomeFirstResponder()
                return false
            default:

                encomenda.descricao = textoNovo
                delegate?.salvarEncomenda(encomenda)
        }
        return true
    }
}
