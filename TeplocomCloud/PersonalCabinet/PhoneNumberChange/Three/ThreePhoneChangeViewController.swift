//
//  ThreePhoneChangeTableViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 12.08.2021.
//

import UIKit

// MARK: - Display logic protocol

protocol ThreePhoneChangeDisplayLogic: AnyObject {
    func displayData(viewModel: ThreePhoneChange.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class ThreePhoneChangeViewController: UIViewController {

    // MARK: - Private Properties

    private var interactor: ThreePhoneChangeBusinessLogic?
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
        let interactor = ThreePhoneChangeInteractor()
        let presenter = ThreePhoneChangePresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
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
        standartView.descriptionLabel.text = "На старый номер придет SMS"

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
    }
}

// MARK: - Display Logic Extension

extension ThreePhoneChangeViewController: ThreePhoneChangeDisplayLogic {
    func displayData(viewModel: ThreePhoneChange.Model.ViewModel.ViewModelData) {
        switch viewModel {

        case .displaySMSCode:
            let alertController = UIAlertController(title: "", message: "Номер телефона успешно изменен", preferredStyle: .alert)
            present(alertController, animated: true, completion: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alertController.dismiss(animated: true) { [weak self] in
                    self?.navigationController?.popToViewController((self?.navigationController?.viewControllers.first)!, animated: true)
                }
            }

        case .error(let description):
            showAlert(with: "Ошибка", and: description)
        }
    }
}
