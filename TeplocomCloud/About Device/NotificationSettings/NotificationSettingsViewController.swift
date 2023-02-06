//
//  NotificationSettingsViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol NotificationSettingsDisplayLogic: AnyObject {
    func displayData(event: NotificationSettings.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class NotificationSettingsViewController: UIViewController {

    // MARK: - Properties

    private(set) var router: NotificationSettingsRoutingLogic?
    private var interactor: NotificationSettingsBusinessLogic?

    private let notifyIntervalPickerDataArray = (1...30).map { "\($0)" }
    private let notifyQuantityPickerDataArray = (1...10).map { "\($0)" }

    private var notifyInterval: Int = 0
    private var notifyQuantity: Int = 0

    // MARK: - Interface Properties

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        return table
    }()

    // Notify Interval
    private lazy var notifyIntervalCell = createCell()
    private lazy var notifyIntervalLabel: UILabel = {
        let label = UILabel()
        label.text = "Интервал оповещения"
        return label
    }()
    private lazy var notifyIntervalPicker = UIPickerView()

    // Notify Quantity
    private lazy var notifyQuantityCell = createCell()
    private lazy var notifyQuantityLabel: UILabel = {
        let label = UILabel()
        label.text = "Кол. повторных оповещений"
        return label
    }()
    private lazy var notifyQuantityPicker = UIPickerView()

    // Notify by SMS
    private lazy var notifySMSCell = createCell()
    private lazy var notifySMSLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомлять по SMS"
        return label
    }()
    private lazy var notifySMSSwitch = UISwitch()

    // Notify by call
    private lazy var notifyCallCell = createCell()
    private lazy var notifyCallLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомлять звонком"
        return label
    }()
    private lazy var notifyCallSwitch = UISwitch()

    // MARK: - LifeCycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCleanSwift()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCleanSwift()
    }

    private func setupCleanSwift() {
        let viewController = self
        let interactor = NotificationSettingsInteractor()
        let presenter = NotificationSettingsPresenter()
        let router = NotificationSettingsRouter()

        viewController.router = router
        router.viewController = viewController

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        interactor?.makeRequest(event: .fetchSettings)
    }

    // MARK: - Private Methods

    private func configureUI() {
        // Table View
        view.addSubview(tableView)
        tableView.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self

        // Notify Interval
        notifyIntervalCell.contentView.addSubview(notifyIntervalPicker)
        notifyIntervalCell.contentView.addSubview(notifyIntervalLabel)
        notifyIntervalLabel.anchor(top: notifyIntervalCell.topAnchor, left: notifyIntervalCell.leftAnchor, bottom: notifyIntervalCell.bottomAnchor, right: notifyIntervalPicker.leftAnchor, paddingLeft: 16)
        notifyIntervalPicker.anchor(top: notifyIntervalCell.topAnchor, left: notifyIntervalLabel.rightAnchor, bottom: notifyIntervalCell.bottomAnchor, right: notifyIntervalCell.rightAnchor, paddingRight: 16, width: 100)

        // Notify Quantity
        notifyQuantityCell.contentView.addSubview(notifyQuantityPicker)
        notifyQuantityCell.contentView.addSubview(notifyQuantityLabel)
        notifyQuantityLabel.anchor(top: notifyQuantityCell.topAnchor, left: notifyQuantityCell.leftAnchor, bottom: notifyQuantityCell.bottomAnchor, right: notifyQuantityPicker.leftAnchor, paddingLeft: 16)
        notifyQuantityPicker.anchor(top: notifyQuantityCell.topAnchor, left: notifyQuantityLabel.rightAnchor, bottom: notifyQuantityCell.bottomAnchor, right: notifyQuantityCell.rightAnchor, paddingRight: 16, width: 100)

        notifyIntervalPicker.delegate = self
        notifyIntervalPicker.dataSource = self
        notifyQuantityPicker.delegate = self
        notifyQuantityPicker.dataSource = self

        // Notify by SMS
        notifySMSCell.contentView.addSubview(notifySMSLabel)
        notifySMSCell.contentView.addSubview(notifySMSSwitch)
        notifySMSLabel.anchor(top: notifySMSCell.topAnchor, left: notifySMSCell.leftAnchor, bottom: notifySMSCell.bottomAnchor, right: notifySMSSwitch.leftAnchor, paddingLeft: 16)
        notifySMSSwitch.centerY(inView: notifySMSCell.contentView)
        notifySMSSwitch.anchor(left: notifySMSLabel.rightAnchor, right: notifySMSCell.rightAnchor, paddingRight: 28)

        // Notify by call
        notifyCallCell.contentView.addSubview(notifyCallLabel)
        notifyCallCell.contentView.addSubview(notifyCallSwitch)
        notifyCallLabel.anchor(top: notifyCallCell.topAnchor, left: notifyCallCell.leftAnchor, bottom: notifyCallCell.bottomAnchor, right: notifyCallSwitch.leftAnchor, paddingLeft: 16)
        notifyCallSwitch.centerY(inView: notifyCallCell.contentView)
        notifyCallSwitch.anchor(left: notifyCallLabel.rightAnchor, right: notifyCallCell.rightAnchor, paddingRight: 28)

        setupNavigationBar()
    }

    private func setupUI(with model: NotificationSettingsModel) {
        notifyInterval = model.notifyInterval
        notifyQuantity = model.notifyQuantity
        notifyIntervalPicker.selectRow(model.notifyInterval - 1, inComponent: 0, animated: true)
        notifyQuantityPicker.selectRow(model.notifyQuantity - 1, inComponent: 0, animated: true)
        notifySMSSwitch.isOn = model.notifyBySms
        notifyCallSwitch.isOn = model.notifyByCall
    }

    private func createCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }

    private func setupNavigationBar() {
        title = "Настройки уведомления"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        // title customization
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance

        // Back button
        let backImage = UIImage(systemName: "chevron.left")!.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton

        // Save button
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    // MARK: - Selectors

    @objc func saveButtonTapped() {
        let notificationSettingsParameters: [String: Any] = ["notifyInterval": notifyInterval,
                                                             "notifyQuantity": notifyQuantity,
                                                             "notifyBySms": notifySMSSwitch.isOn,
                                                             "notifyByCall": notifyCallSwitch.isOn]
        interactor?.makeRequest(event: .editSettings(parameters: notificationSettingsParameters))
    }

    @objc func backButtonTapped() {
        router?.dismiss()
    }
}

// MARK: - Display Logic Extention

extension NotificationSettingsViewController: NotificationSettingsDisplayLogic {
    func displayData(event: NotificationSettings.Model.ViewModel.ViewModelData) {
        switch event {
        case .fetchSettings(data: let data):
            setupUI(with: data)
        case .editSettings(status: let status):
            var title = ""
            var description = ""
            switch status {
            case 202:
                title = "Успешно"
                description = "Задача поставлена в работу"
            case 400:
                title = "Ошибка"
                description = "Неверные входные параметры"
            case 404:
                title = "Ошибка"
                description = "Устройство отсутствует или не привязано к пользователю"
            default:
                title = "Ошибка"
                description = "Произошла ошибка"
            }

            showAlert(with: title, and: description) { [weak self] in
                self?.router?.dismiss()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource Extension

extension NotificationSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return notifyIntervalCell
        case 1: return notifyQuantityCell
        case 2: return notifySMSCell
        case 3: return notifyCallCell

        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 80
        case 1: return 80
        case 2: return UITableView().estimatedRowHeight
        case 3: return UITableView().estimatedRowHeight

        default: return 0
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension NotificationSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == notifyIntervalPicker {
            return notifyIntervalPickerDataArray.count
        } else {
            return notifyQuantityPickerDataArray.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == notifyIntervalPicker {
            return notifyIntervalPickerDataArray[row]
        } else {
            return notifyQuantityPickerDataArray[row]
        }

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == notifyIntervalPicker {
            notifyInterval = Int(notifyIntervalPickerDataArray[row].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
        } else {
            notifyQuantity = Int(notifyQuantityPickerDataArray[row].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
        }
    }
}
