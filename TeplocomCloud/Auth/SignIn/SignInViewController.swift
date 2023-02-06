//
//  SignInViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 25.01.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol SignInDisplayLogic: AnyObject {
    func displayData(viewModel: SignIn.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class SignInViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: SignInRoutingLogic?

    // MARK: - Private Properties

    private var interactor: SignInBusinessLogic?

    private var phoneNumberString: String = ""
    private let standartView = StandartView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        configureUI()
    }

    // MARK: - Private Methods

    private func setup() {
        let viewController = self
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        let router = SignInRouter()
        viewController.router = router
        router.viewController = viewController
    }

    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(standartView)
        standartView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor)

        standartView.standartViewType = .phoneNumber

        standartView.completion = { [unowned self] in

            phoneNumberString = standartView.standartTextFieldString
            fetchSMSCode()
        }
    }

    private func fetchSMSCode() {

        if phoneNumberString.count == 12 {
            let parameters = ["phoneNumber": phoneNumberString]
            interactor?.makeRequest(request: .fetchAuthCode(parameters: parameters))
        } else {
            
            showAlert(with: "Ошибка ввода", and: "Проверьте правильность номера телефона") {
                self.phoneNumberString = ""
                self.standartView.standartViewType = .phoneNumberError
            }
        }
    }

}

// MARK: - Display Logic Extention

extension SignInViewController: SignInDisplayLogic {
    func displayData(viewModel: SignIn.Model.ViewModel.ViewModelData) {
        switch viewModel {

        case .displayAuthCode:
            router?.navigateToSMSCodeScreen(navigateType: .showSMSCodeScreen(phoneNumber: phoneNumberString))

        case .error(description: let description):
            self.showAlert(with: "Ошибка", and: description)
        }
    }

}
