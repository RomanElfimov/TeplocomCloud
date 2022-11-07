//
//  AboutDeviceViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.07.2022.
//

import UIKit

// MARK: - Display Logic protocol

protocol AboutDeviceDisplayLogic: AnyObject {
    func displayData(event: AboutDevice.Model.ViewModel.ViewModelData)
}

final class AboutDeviceViewController: UIViewController {

    // MARK: - Properties

    private(set) var router: AboutDeviceRoutingLogic?
    private var interactor: AboutDeviceBusinessLogic?

    // MARK: - Interface Properties

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        return table
    }()

    // Save button in navigation bar
    private lazy var saveButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = "Сохранить"
        btn.style = .plain
        btn.target = self
        btn.action = #selector(saveButtonTapped)
        return btn
    }()

    // Device name
    private lazy var deviceNameCell = createCell()

    private lazy var deviceNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Имя устройства"
        tf.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tf.borderStyle = .none
        return tf
    }()

    private lazy var deviceNameEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.tintColor = UIColor(named: "TeplocomColor")
        return button
    }()

    // Текущая версия прошивки
    private lazy var currentFirmwareVersionCell = createCell()

    private lazy var currentFirmwareVersionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    // Версия прошивки, на которую можно обновиться
    private lazy var availableFirmwareVersionCell = createCell()

    private lazy var availableFirmwareVersionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    // Настройки уведомлений
    private lazy var notificationSettingsCell = createCell()

    private lazy var notificationSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки уведомления устройством"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

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
        let interactor = AboutDeviceInteractor()
        let presenter = AboutDevicePresenter()
        let router = AboutDeviceRouter()

        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController

        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

        interactor?.makeRequest(event: .fetchNeedUpdateFirmware)
        interactor?.makeRequest(event: .fetchDeviceInfo)
    }

    // MARK: - Private Methods

    private func configureUI() {
        // Table View
        view.addSubview(tableView)
        tableView.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self

        // Device name
        deviceNameCell.contentView.addSubview(deviceNameTextField)
        deviceNameCell.contentView.addSubview(deviceNameEditButton)

        deviceNameTextField.anchor(top: deviceNameCell.topAnchor, left: deviceNameCell.leftAnchor, bottom: deviceNameCell.bottomAnchor, right: deviceNameEditButton.leftAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 8, paddingRight: 8)
        deviceNameTextField.isUserInteractionEnabled = false
        deviceNameTextField.delegate = self
        deviceNameEditButton.anchor(top: deviceNameCell.topAnchor, bottom: deviceNameCell.bottomAnchor, right: deviceNameCell.rightAnchor, paddingTop: 8, paddingBottom: 8, paddingRight: 8, width: 50)

        // Current Firmware Version
        currentFirmwareVersionCell.addSubview(currentFirmwareVersionLabel)
        currentFirmwareVersionLabel.anchor(top: currentFirmwareVersionCell.topAnchor, left: currentFirmwareVersionCell.leftAnchor, bottom: currentFirmwareVersionCell.bottomAnchor, right: currentFirmwareVersionCell.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 16, paddingRight: 8)

        // Available Firmware Version
        availableFirmwareVersionCell.addSubview(availableFirmwareVersionLabel)
        availableFirmwareVersionLabel.anchor(top: availableFirmwareVersionCell.topAnchor, left: availableFirmwareVersionCell.leftAnchor, bottom: availableFirmwareVersionCell.bottomAnchor, right: availableFirmwareVersionCell.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 16, paddingRight: 8)

        // Notification Settings
        notificationSettingsCell.addSubview(notificationSettingsLabel)
        notificationSettingsCell.accessoryType = .disclosureIndicator
        notificationSettingsCell.selectionStyle = .default
        notificationSettingsLabel.anchor(top: notificationSettingsCell.topAnchor, left: notificationSettingsCell.leftAnchor, bottom: notificationSettingsCell.bottomAnchor, right: notificationSettingsCell.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 16, paddingRight: 8)

        // setup nav bar
        setupNavigationBar()
    }

    private func setupUI(with model: DeviceInfoViewModel) {
        deviceNameTextField.text = model.deviceName
        currentFirmwareVersionLabel.text = model.currentFirmwareVersion
        availableFirmwareVersionLabel.text = model.availableFirmwareVersion
    }

    private func createCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }

    private func displayUpdateFirmwareAlert(with completion: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "Обновление", message: "Доступна новая версия прошивки", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Обновить", style: .cancel, handler: completion)
        let okAction = UIAlertAction(title: "Отмена", style: .default)
        alertController.addAction(updateAction)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    private func setupNavigationBar() {
        title = "Об устройстве"
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
    }

    // MARK: - Selectors

    @objc func editButtonTapped() {
        deviceNameTextField.isUserInteractionEnabled = true
        deviceNameTextField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc func saveButtonTapped() {
        guard let deviceName = deviceNameTextField.text, deviceName != "" else {
            showAlert(with: "Ошибка", and: "Укажите имя устройства")
            return
        }
        interactor?.makeRequest(event: .editDeviceInfo(parameters: ["deviceClientName": deviceName]))
        navigationItem.rightBarButtonItem = nil
        deviceNameTextField.isUserInteractionEnabled = false
        deviceNameTextField.resignFirstResponder()
    }

    @objc func backButtonTapped() {
        // router.dismiss(animated: true)
        dismiss(animated: true)
    }

}

// MARK: - Display Logic Extension

extension AboutDeviceViewController: AboutDeviceDisplayLogic {
    func displayData(event: AboutDevice.Model.ViewModel.ViewModelData) {
        switch event {
        case .displayNeedUpdateFirmware(let data):
            if data.isAvailable {
                displayUpdateFirmwareAlert { [weak self] _ in
                    self?.interactor?.makeRequest(event: .reflashFirmware)
                }
            }

        case .displayDeviceInfo(let data):
            setupUI(with: data)

        case .editDeviceInfo(status: let status):
            var title = ""
            var description = ""
            switch status {
            case 200:
                title = "Успешно"
                description = "Клиентское наименование изменено"
            case 400:
                title = "Ошибка"
                description = "Ошибка входных параметров"
            case 404:
                title = "Ошибка"
                description = "Устройство не привязано к пользователю"
            default:
                title = "Ошибка"
                description = "Неизвестная ошибка"
            }
            showAlert(with: title, and: description)

        case .reflashFirmware(status: let status):
            var title = ""
            var description = ""
            switch status {
            case 202:
                title = "Успешно"
                description = "Задача обновления поставлена в работу"
            default:
                title = "Ошибка"
                description = "Во время запроса произошла ошибка"
            }
            showAlert(with: title, and: description)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource Extension

extension AboutDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return deviceNameCell
        case 1: return currentFirmwareVersionCell
        case 2: return availableFirmwareVersionCell
        case 3: return notificationSettingsCell

        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 60
        case 1: return UITableView().estimatedRowHeight
        case 2: return UITableView().estimatedRowHeight
        case 3: return UITableView().estimatedRowHeight

        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            tableView.deselectRow(at: indexPath, animated: true)
            router?.showNotificationSettings()
        }
    }
}

// MARK: - UITextFieldDelegate Extension

extension AboutDeviceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = nil
        textField.isUserInteractionEnabled = false
        textField.resignFirstResponder()

        return true
    }
}
