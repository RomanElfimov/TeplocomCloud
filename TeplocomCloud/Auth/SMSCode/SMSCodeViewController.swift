//
//  SMSCodeViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 25.01.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol SMSCodeDisplayLogic: AnyObject {
    func displayData(viewModel: SMSCode.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class SMSCodeViewController: UIViewController {

    // MARK: - Public Properties

    var phoneNumberString: String = ""
    private(set) var router: (SMSCodeRoutingLogic & SMSCodeDataPassingProtocol)?

    // MARK: - Private Property

    private var interactor: (SMSCodeBusinessLogic & SMSCodeDetailsStoreProtocol)?
    private let standartView = StandartView()

    // MARK: - Life Cycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        let viewController = self
        let interactor = SMSCodeInteractor()
        let presenter = SMSCodePresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        let router = SMSCodeRouter()
        router.dataStore = interactor
        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.makeRequest(request: .getPhoneNumber)

        view.addSubview(standartView)
        view.backgroundColor = .white
        standartView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor)

        standartView.standartViewType = .smsCode(phoneNumberString: phoneNumberString)
        standartView.completion = { [unowned self] in

            let smsCode = standartView.standartTextFieldString
            let verifySMSCodeParameters = ["phoneNumber": phoneNumberString,
                                           "code": smsCode]
            interactor?.makeRequest(request: .logIn(parameters: verifySMSCodeParameters))
        }
    }

}

// MARK: - Display Logic Extension

extension SMSCodeViewController: SMSCodeDisplayLogic {
    func displayData(viewModel: SMSCode.Model.ViewModel.ViewModelData) {
        switch viewModel {

        case .displayPhoneNumber(phoneNumber: let phoneNumber):
            phoneNumberString = phoneNumber
            standartView.standartViewType = .smsCode(phoneNumberString: phoneNumberString)

        case .displayLogIn:
            router?.showMainScreen(navigateType: .showBindedDevicesListScreen)

        case .error(let description):
            self.showAlert(with: "Ошибка", and: description)
        }
    }
}
