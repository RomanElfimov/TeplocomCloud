//
//  StandartView.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 25.01.2022.
//

import UIKit

// MARK: - StandartViewType

/// Enumeration of view's type
enum StandartViewType {
    case phoneNumber
    case phoneNumberError
    case smsCode(phoneNumberString: String)
}

// MARK: - StandartView

final class StandartView: UIView {

    // MARK: - Public Properties

    public var completion: (() -> Void)?
    public var standartTextFieldString: String = ""

    public var standartViewType: StandartViewType? {
        didSet { configureUI() }
    }

    // MARK: - Interface Properties

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TeplocomMainLogo")
        return iv
    }()

    private lazy var phoneNumberContainterView: UIView = {
        let view = StandartViewUtilites().inputContainerView(withImage: phoneImage!, textField: phoneTextField)
        return view
    }()

    private var phoneImage = UIImage(named: "")

    private let phoneTextField: UITextField = {
        let tf = StandartViewUtilites().textField(withPlaceholder: "Номер телефона")
        return tf
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона должен начинатся с +7"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor(named: "TeplocomColor")
        label.numberOfLines = 0
        return label
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.widthAnchor.constraint(equalToConstant: 278).isActive = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTappedAction), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    private func formatPhoneNumber(number: String) -> String {

        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        standartTextFieldString = "+\(cleanPhoneNumber)"

        let mask = "+X (XXX) XXX-XX-XXX"
        var result = ""
        var index = cleanPhoneNumber.startIndex

        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }

        return result
    }

    // MARK: - Configuring UI

    func configureUI() {

        var image = UIImage()
        var placeholder = ""
        var description = ""
        var buttonTitle = ""

        switch standartViewType {
        case .phoneNumber:
            image = UIImage(named: "phoneIcon")!
            placeholder = "Номер телефона"
            description = "Номер телефона должен начинаться с +7"
            buttonTitle = "Далее"

            phoneTextField.keyboardType = .phonePad
            phoneTextField.text = "+7"
            phoneTextField.delegate = self

        case .phoneNumberError:
            image = UIImage(named: "phoneIcon")!
            placeholder = "Номер телефона"
            description = "Номер телефона должен начинаться с +7"
            buttonTitle = "Далее"

            standartTextFieldString = ""
            phoneTextField.keyboardType = .phonePad
            phoneTextField.text = ""
            phoneTextField.text = "+7"

        case .smsCode(let phoneNumberString):
            image = UIImage(named: "smsCodeIcon")!
            placeholder = "Код из SMS"
            description = "Мы выслали код подтверждения на номер \n \(phoneNumberString)"
            buttonTitle = "Подтвердить"

            phoneTextField.keyboardType = .numberPad
            phoneTextField.textContentType = .oneTimeCode
            phoneTextField.text = ""
            phoneTextField.addTarget(self, action: #selector(smsTextFieldAction), for: .editingChanged)
        case .none:
            break
        }

        self.backgroundColor = .white

        self.addSubview(logoImageView)
        logoImageView.centerX(inView: self, topAnchor: self.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        logoImageView.setDimensions(width: 150, height: 150)

        phoneImage = image
        phoneTextField.placeholder = placeholder
        descriptionLabel.text = description
        continueButton.setTitle(buttonTitle, for: .normal)
        continueButton.isEnabled = false

        let stack = UIStackView(arrangedSubviews: [phoneNumberContainterView,
                                                   descriptionLabel,
                                                   continueButton
                                                  ])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually

        self.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 50, paddingLeft: 24, paddingRight: 24)

        self.addSubview(continueButton)
        continueButton.centerX(inView: self, topAnchor: stack.bottomAnchor, paddingTop: 32)
    }

    // MARK: - Selectors

    @objc func buttonTappedAction() {
        completion?()
    }

    @objc func smsTextFieldAction() {
        if phoneTextField.text?.count == 6 {
            continueButton.isEnabled = true
            phoneTextField.resignFirstResponder()
            standartTextFieldString = phoneTextField.text ?? ""
        } else {
            continueButton.isEnabled = false
        }
    }
}

// MARK: - Extension TextField Delegate

extension StandartView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatPhoneNumber(number: newString)

        if standartTextFieldString.count == 12 {
            continueButton.isEnabled = true
            textField.resignFirstResponder()
        }

        return false
    }
}
