//
//  PhoneNumberChangeViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.08.2021.
//

import UIKit

// MARK: - Display Logic Protocol

protocol PhoneNumberChangeDisplayLogic: AnyObject {
    func displayData(viewModel: PhoneNumberChange.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class PhoneNumberChangeViewController: UIViewController {

    // MARK: - External vars

    private(set) var router: PhoneNumberChangeRoutingLogic?

    // MARK: - Internal vars

    private var interactor: PhoneNumberChangeBusinessLogic?
    private var phoneNumberString: String = ""

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
        let interactor = PhoneNumberChangeInteractor()
        let presenter = PhoneNumberChangePresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        let router = PhoneNumberChangeRouter()
        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        view.backgroundColor = .white

        view.addSubview(standartView)
        standartView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.rightAnchor)

        standartView.standartViewType = .phoneNumber
        standartView.descriptionLabel.text = "Введите новый номер телефона. Мы вышлем на него код подтверждения"

        standartView.completion = { [unowned self] in

            phoneNumberString = standartView.standartTextFieldString

            if phoneNumberString.count == 12 {

                let parameters = ["phoneNumber": phoneNumberString]
                interactor?.makeRequest(request: .fetchPhoneNumberChange(newPhoneParameters: parameters))
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

// MARK: - Extension DisplayLogic

extension PhoneNumberChangeViewController: PhoneNumberChangeDisplayLogic {
    func displayData(viewModel: PhoneNumberChange.Model.ViewModel.ViewModelData) {

        switch viewModel {

        case .displayPhoneNumberChange:
            router?.navigateTo(navigationType: .showSecondPhoneChangeScreen)

        case .error(description: let description):
            showAlert(with: "Ошибка", and: description)
        }
    }
}
