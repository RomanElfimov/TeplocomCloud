//
//  EmailChangeTableViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import UIKit

// MARK: - Display Logic Protocol

protocol EmailManagementDisplayLogic: AnyObject {
    func displayData(viewModel: EmailManagement.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class EmailManagementViewController: UIViewController {

    // MARK: - Public Properties

    public var userEmail: String = ""
    public var isEmailVerified: Bool = false

    private(set) var router: (EmailManagementRoutingLogic & EmailManagementDataPassingProtocol)?

    // MARK: - Internal vars

    private var interactor: (EmailManagementBusinessLogic & EmailManagementStoreProtocol)?

    // MARK: - Interface Properties

    private let changeEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Смена Email"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private let newEmailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Новый email"
        tf.keyboardType = .emailAddress
        tf.keyboardType = .emailAddress
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.borderStyle = .roundedRect
        return tf
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveNewEmailButtonTapped), for: .touchUpInside)
        return button
    }()

    // Verify email
    private let verifyEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение Email"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private let verifyEmailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Для подтверждения email мы вышлем на почту ссылку верификации"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()

    private let confirmedEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "testexample@gmail.com"
        label.textColor = UIColor(named: "TeplocomColor")
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(confirmEmailButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = EmailManagementInteractor()
        let presenter = EmailManagementPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        let router = EmailManagementRouter()
        viewController.router = router
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newEmailTextField.delegate = self
        setupNavigationBar()

        interactor?.makeRequest(request: .getEmailData)
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor = .white

        // Change email
        let stack = UIStackView(arrangedSubviews: [
            changeEmailLabel,
            newEmailTextField])

        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 24, paddingRight: 24)

        view.addSubview(continueButton)
        continueButton.anchor(top: stack.bottomAnchor, paddingTop: 35)
        continueButton.centerX(inView: view)
        continueButton.setDimensions(width: 278, height: 50)

        // verify email
        let verifyEmailstack = UIStackView(arrangedSubviews: [
            verifyEmailLabel,
            verifyEmailDescriptionLabel,
            confirmedEmailLabel
        ])

        verifyEmailstack.axis = .vertical
        verifyEmailstack.spacing = 20
        verifyEmailstack.distribution = .fillEqually

        view.addSubview(verifyEmailstack)
        verifyEmailstack.anchor(top: continueButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 70, paddingLeft: 24, paddingRight: 24)

        view.addSubview(confirmButton)
        confirmButton.anchor(top: verifyEmailstack.bottomAnchor, paddingTop: 35)
        confirmButton.centerX(inView: view)
        confirmButton.setDimensions(width: 278, height: 50)

        if isEmailVerified {
            stack.isHidden = false
            continueButton.isHidden = false
            verifyEmailstack.isHidden = true
            confirmButton.isHidden = true
        } else {
            verifyEmailstack.isHidden = false
            confirmButton.isHidden = false
        }
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance
    }

    // MARK: - Selectors

    @objc private func saveNewEmailButtonTapped() {
        guard let newEmail = newEmailTextField.text, newEmail != "" else {
            showAlert(with: "Неверный email", and: "Убедитесь в правильность заполения этого поля")
            return
        }

        let newEmailParameters: [String: String] = ["email": newEmail]
        interactor?.makeRequest(request: .changeEmail(newEmailParameters: newEmailParameters))
    }

    @objc private func confirmEmailButtonTapped() {
        let newEmailParameters: [String: String] = ["email": userEmail]
        interactor?.makeRequest(request: .verifyEmail(emailParameters: newEmailParameters))
    }
}

// MARK: - Extension DisplayLogic

extension EmailManagementViewController: EmailManagementDisplayLogic {

    func displayData(viewModel: EmailManagement.Model.ViewModel.ViewModelData) {
        switch viewModel {

        case .displayEmailInfo(let email, let isVerified):
            userEmail = email
            isEmailVerified = isVerified
            confirmedEmailLabel.text = userEmail
            configureUI()

        case .displayChangedEmail(let viewModel):
            userEmail = viewModel.email
            isEmailVerified = false
            confirmedEmailLabel.text = viewModel.email
            configureUI()

        case .displayVerifiedEmail:
            showAlert(with: "Успешно", and: "Мы выслали на ваш email письмо с подтверждением")

        case .error(let description):
            showAlert(with: "Ошибка", and: description)
        }
    }
}

// MARK: - UITextFieldDelegate Extension

extension EmailManagementViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
