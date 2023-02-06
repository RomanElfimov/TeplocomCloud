//
//  SensorSettingsViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 23.03.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol SensorSettingsDisplayLogic: AnyObject {
    func displayData(event: SensorSettings.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller Class

final class SensorSettingsViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: (SensorSettingsRoutingLogic & SensorSettingsDataPassingProtocol)?

    // MARK: - Private Properties

    private var interactor: (SensorSettingsBusinessLogic & SensorSettingsStoreProtocol)?
    private var sensorType: String = ""
    private var sensorID: String = ""

    // MARK: - Interface Properties

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        return table
    }()

    // sensorName
    private lazy var sensorNameCell = SensorsUtilities().createCell()
    private lazy var sensorNameTextField = SensorsUtilities().createTextField(placeholder: "Введите наименование датчика")

    // sensorRole
    private lazy var sensorRoleCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var sensorRoleTextField = SensorsUtilities().createTextField(placeholder: "Роль датчика")
    private let sensorRolePickerView = UIPickerView()

    // minValueCell
    private lazy var minValueCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var minValueTextField = SensorsUtilities().createTextField(placeholder: "Минимальный порог температуры", text: "-5 ˚C")
    private let minValuePickerView = UIPickerView()

    // maxValueCell
    private lazy var maxValueCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var maxValueTextField = SensorsUtilities().createTextField(placeholder: "Максимальный порог температуры", text: "20 ˚C")
    private let maxValuePickerView = UIPickerView()

    // notifications

    private lazy var notificationCell = SensorsUtilities().createCell()
    private lazy var notifLabel: UILabel = {
        let label = UILabel()
        label.text = "Оповещение"
        return label
    }()

    private lazy var notifSwitch: UISwitch = {
        let notifSwitch = UISwitch()
        return notifSwitch
    }()

    // expert mode
    private lazy var expertModelCell = SensorsUtilities().createCell()
    private lazy var expertModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(expertButtonTapped), for: .touchUpInside)
        button.setTitle("Перейти в экспертный режим", for: .normal)
        return button
    }()

    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor(named: "TeplocomColor")
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(dismissTextFieldPicker))
        toolbar.setItems([doneButton], animated: false)
        return toolbar
    }()

    private let sensorRoleDataSourceArray = ["Теплоноситель", "ГВС", "Комната", "Улица", "Информационный", "Неопределенный"]
    private let tempValueDataSourceArray = (-50...150).map { "\($0) ˚C" }

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
        let interactor = SensorSettingsInteractor()
        let presenter = SensorSettingsPresenter()
        let router = SensorSettingsRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        configureUI()

        interactor?.makeRequest(event: .getSensorInfo)
    }

    // MARK: - Private Methods

    private func setupUI(with model: TemperatureSensorViewModel) {
        sensorNameTextField.text = model.clientName
        sensorRoleTextField.text = model.role
        minValueTextField.text = model.lowerLimit
        maxValueTextField.text = model.upperLimit
        notifSwitch.isOn = model.notify
    }

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        // name
        sensorNameCell.contentView.addSubview(sensorNameTextField)
        sensorNameTextField.anchor(top: sensorNameCell.topAnchor, left: sensorNameCell.leftAnchor, bottom: sensorNameCell.bottomAnchor, right: sensorNameCell.rightAnchor, paddingLeft: 16)

        // role
        sensorRoleCell.contentView.addSubview(sensorRoleTextField)
        sensorRoleTextField.anchor(top: sensorRoleCell.topAnchor, left: sensorRoleCell.leftAnchor, bottom: sensorRoleCell.bottomAnchor, right: sensorRoleCell.rightAnchor, paddingLeft: 16)

        sensorRolePickerView.delegate = self
        sensorRolePickerView.dataSource = self
        sensorRoleTextField.inputView = sensorRolePickerView

        sensorRoleTextField.inputAccessoryView = toolBar

        // minValue
        minValueCell.contentView.addSubview(minValueTextField)
        minValueTextField.anchor(top: minValueCell.topAnchor, left: minValueCell.leftAnchor, bottom: minValueCell.bottomAnchor, right: minValueCell.rightAnchor, paddingLeft: 16)

        minValuePickerView.delegate = self
        minValuePickerView.dataSource = self
        minValueTextField.inputView = minValuePickerView

        minValueTextField.inputAccessoryView = toolBar

        // maxValue
        maxValueCell.contentView.addSubview(maxValueTextField)
        maxValueTextField.anchor(top: maxValueCell.topAnchor, left: maxValueCell.leftAnchor, bottom: maxValueCell.bottomAnchor, right: maxValueCell.rightAnchor, paddingLeft: 16)

        maxValuePickerView.delegate = self
        maxValuePickerView.dataSource = self
        maxValueTextField.inputView = maxValuePickerView

        maxValueTextField.inputAccessoryView = toolBar

        // notifications
        notificationCell.contentView.addSubview(notifLabel)
        notificationCell.contentView.addSubview(notifSwitch)

        notifLabel.centerY(inView: notificationCell.contentView)
        notifLabel.anchor(left: notificationCell.leftAnchor, right: notifSwitch.rightAnchor, paddingLeft: 16)

        notifSwitch.centerY(inView: notificationCell.contentView)
        notifSwitch.anchor(right: notificationCell.rightAnchor, paddingRight: 16)

        // expert mode
        expertModelCell.contentView.addSubview(expertModeButton)
        expertModeButton.cornerRadius = 7
        expertModeButton.anchor(top: expertModelCell.topAnchor, left: expertModelCell.leftAnchor, bottom: expertModelCell.bottomAnchor, right: expertModelCell.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }

    private func setupNavigationBar() {
        title = "Настройки датчика"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // background color
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance

        // Left button - Cancel
        let menuButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
        menuButton.tintColor = .white
        navigationItem.leftBarButtonItem = menuButton

        // Right button - Save
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        saveButton.tintColor = .white
        navigationItem.rightBarButtonItem = saveButton
    }

    // MARK: - Selectors

    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveButtonTapped() {
        guard let clientName = sensorNameTextField.text, clientName != "" else {
            showAlert(with: "", and: "Укажите имя датчика")
            return
        }

        guard let lowerLimit = minValueTextField.text, lowerLimit != "" else {
            showAlert(with: "", and: "Укажите минимальное значение")
            return
        }
        let minValue = lowerLimit.replacingOccurrences(of: " ˚C", with: "")

        guard let upperLimit = maxValueTextField.text, upperLimit != "" else {
            showAlert(with: "", and: "Укажите максимальное значение")
            return
        }
        let maxValue = upperLimit.replacingOccurrences(of: " ˚C", with: "")

        guard let sensorRole = sensorRoleTextField.text else { return }

        let parameters: [String: Any] = ["clientName": clientName,
                                         "lowerLimit": Int(minValue) ?? 0,
                                         "notify": notifSwitch.isOn,
                                         "role": sensorRole,
                                         "upperLimit": Int(maxValue) ?? 0]

        if sensorType == "" {
            interactor?.makeRequest(event: .editSensor(parameters: parameters))
        } else {
            interactor?.makeRequest(event: .addNewSensor(parameters: parameters))
        }
    }

    @objc func dismissTextFieldPicker() {
        sensorRoleTextField.resignFirstResponder()
        minValueTextField.resignFirstResponder()
        maxValueTextField.resignFirstResponder()
    }

    @objc func expertButtonTapped() {
        router?.navigateToExpertSettings(sensorId: sensorID)
    }
}

// MARK: - Extension DisplayLogic

extension SensorSettingsViewController: SensorSettingsDisplayLogic {
    func displayData(event: SensorSettings.Model.ViewModel.ViewModelData) {

        var title: String = ""
        var description: String = ""

        switch event {
        case .displaySensorInfo(let sensorId, let sensorType):
            self.sensorType = sensorType
            self.sensorID = sensorId

            sensorRoleTextField.text = sensorType

            if sensorType == "" {
                interactor?.makeRequest(event: .fetchSensorSettings)
            }

        case .displayAddNewSensor(let status):
            switch status {
            case 202:
                title = "Успешно"
                description = "Добавлен новый датчик"
            case 400:
                title = "Ошибка"
                description = "Неверные входные параметры"
            case 404:
                title = "Ошибка"
                description = "Устройство не привязано к пользователю"
            default:
                title = "Ошибка"
                description = "Произошла неизвестная ошибка"
            }

            showAlert(with: title, and: description, completion: router!.dismiss)

        case .displayEditSensor(let status):
            switch status {
            case 202:
                title = "Успешно"
                description = "Настройки датичка изменены"
            case 400:
                title = "Ошибка"
                description = "Неверные входные параметры"
            case 404:
                title = "Ошибка"
                description = "Устройство не привязано к пользователю"
            default:
                title = "Ошибка"
                description = "Произошла неизвестная ошибка"
            }

            showAlert(with: title, and: description)

        case .displaySensorSettings(let data):

            setupUI(with: data)

        }
    }
}

// MARK: - Extension TableView Delegate, DataSource

extension SensorSettingsViewController: UITableViewDelegate, UITableViewDataSource {

    // Rows

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 3
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            return sensorNameCell
        case 1:
            return sensorRoleCell
        case 2:
            return minValueCell
        case 3:
            if indexPath.row == 1 {
                return UITableViewCell()
            }
            if indexPath.row == 2 {
                return notificationCell
            }
            return maxValueCell
        case 4:
            return expertModelCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            return 50
        case 2:
            return 65
        case 3:
            return 50
        case 4:
            return 82
        default:
            return 0
        }
    }

    // Sections

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Наименование"
        case 1:
            return "Роль датчика"
        case 2:
            return "Минимальное значение"
        case 3:
            return "Максимальное значение"
        case 4:
            return " "
        default:
            return ""
        }
    }

}

// MARK: - Extension PickerView Delegate, DataSource

extension SensorSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch pickerView {
        case sensorRolePickerView:
            return sensorRoleDataSourceArray.count
        case minValuePickerView:
            return tempValueDataSourceArray.count
        case maxValuePickerView:
            return tempValueDataSourceArray.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sensorRolePickerView:
            return sensorRoleDataSourceArray[row]
        case minValuePickerView:
            return tempValueDataSourceArray[row]
        case maxValuePickerView:
            return tempValueDataSourceArray[row]
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sensorRolePickerView:
            sensorRoleTextField.text = sensorRoleDataSourceArray[row]
        case minValuePickerView:
            minValueTextField.text = tempValueDataSourceArray[row]
        case maxValuePickerView:
            maxValueTextField.text = tempValueDataSourceArray[row]
        default:
            break
        }
    }

}
