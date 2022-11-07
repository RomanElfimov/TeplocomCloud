//
//  TwoPhoneChangeTableViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import UIKit

// MARK: - Display logic protocol

protocol TwoPhoneChangeDisplayLogic: AnyObject {
    func displayData(viewModel: TwoPhoneChange.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class TwoPhoneChangeViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: TwoPhoneChangeRoutingLogic?

    // MARK: - Internal vars

    private var interactor: TwoPhoneChangeBusinessLogic?
    private let standartView = StandartView()

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
        let interactor = TwoPhoneChangeInteractor()
        let presenter = TwoPhoneChangePresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        let router = TwoPhoneChangeRouter()
        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        view.addSubview(standartView)

        view.backgroundColor = .white
        standartView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor)

        standartView.standartViewType = .smsCode(phoneNumberString: "")
        standartView.descriptionLabel.text = "На новый номер придет SMS"

        standartView.completion = { [unowned self] in

            let SMSCode = standartView.standartTextFieldString
            if SMSCode != "", SMSCode.count == 6 {
                let smsCodeParamters = ["code": SMSCode]
                interactor?.makeRequest(request: .fetchSMSCode(parameters: smsCodeParamters))
            } else {
                showAlert(with: "", and: "Убедитесь в правильности заполения SMS кода")
            }
        }
    }

    // MARK: - Private Method

    private func setupNavigationBar() {
        title = "Смена номера телефона"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TeplocomColor") // .systemGray6
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance
        navigationItem.backButtonTitle = ""
    }
}

// MARK: - Display Logic Extension

extension TwoPhoneChangeViewController: TwoPhoneChangeDisplayLogic {
    func displayData(viewModel: TwoPhoneChange.Model.ViewModel.ViewModelData) {

        switch viewModel {
        case .displaySMSCode:
            router?.navigateToDetail(navigationType: .showThirdPhoneChangeScreen)

        case .error(let description):

            showAlert(with: "Ошибка", and: description)
        }
    }
}
