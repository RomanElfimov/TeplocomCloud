//
//  ExpertSettingsViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 03.04.2022.
//

import UIKit

class SensorsExpertSettingsViewController: UIViewController {

    // MARK: - Interface Propeties

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        return table
    }()

    // Окно интеграции
    private lazy var intergrationWindowCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var intergrationWindowTextField = SensorsUtilities().createTextField(placeholder: "Установите значение")
    private let intergrationWindowPickerView = UIPickerView()

    // Настройки при аварии

    private lazy var failureValueCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var failureValueTextField = SensorsUtilities().createTextField(placeholder: "Установите значение")
    private let failureValuePickerView = UIPickerView()

    private lazy var minNotificationCell = SensorsUtilities().createCell()
    private lazy var minNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Оповещение при достижении минимума"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    private let minNotificationSwitch = UISwitch()

    private lazy var maxNotificationCell = SensorsUtilities().createCell()
    private lazy var maxNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Оповещение при достижении максимума"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    private let maxNotificationSwitch = UISwitch()

    private lazy var failureNotificationCell = SensorsUtilities().createCell()
    private lazy var failureNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Оповещение при аварии"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    private let failureNotificationSwitch = UISwitch()

    // Интервал оповещения
    private lazy var notificationIntervalCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var notificationIntervalTextField = SensorsUtilities().createTextField(placeholder: "Установите значение")
    private let notificationIntervalPicker = UIPickerView()

    // Количество повторных оповещений
    private lazy var repeatNotificationsCountCell = SensorsUtilities().createCell(isDisclosure: true)
    private lazy var repeatNotificationsCountTextField = SensorsUtilities().createTextField(placeholder: "Установите значение")
    private let repeatNotificationsPicker = UIPickerView()

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

    private let intergrationWindowDataSourceArray = ["cvbn", "gfd", "fd", "dqa", "", ""]
    private let failureValueDataSourceArray = ["", "", "", "", "", "", ""]
    private let notificationIntervalDataSourceArray = [""]
    private let repeatNotificationsDataSourceArray = [""]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        configureUI()
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        title = "Экспертные настройки"
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

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        intergrationWindowCell.contentView.addSubview(intergrationWindowTextField)
        intergrationWindowTextField.anchor(top: intergrationWindowCell.topAnchor, left: intergrationWindowCell.leftAnchor, bottom: intergrationWindowCell.bottomAnchor, right: intergrationWindowCell.rightAnchor, paddingLeft: 16)

        intergrationWindowPickerView.delegate = self
        intergrationWindowPickerView.dataSource = self
        intergrationWindowTextField.inputView = intergrationWindowPickerView
        intergrationWindowTextField.inputAccessoryView = toolBar

        // Установить значение при аварии

        failureValueCell.contentView.addSubview(failureValueTextField)
        failureValueTextField.anchor(top: failureValueCell.topAnchor, left: failureValueCell.leftAnchor, bottom: failureValueCell.bottomAnchor, right: failureValueCell.rightAnchor, paddingLeft: 16)

        failureValuePickerView.delegate = self
        failureValuePickerView.dataSource = self
        failureValueTextField.inputView = failureValuePickerView
        failureValueTextField.inputAccessoryView = toolBar

        let labelStack = UIStackView(arrangedSubviews: [minNotificationLabel, maxNotificationLabel, failureNotificationLabel])
        labelStack.axis = .vertical
        labelStack.distribution = .equalSpacing
        let switchesStack = UIStackView(arrangedSubviews: [minNotificationSwitch, maxNotificationSwitch, failureNotificationSwitch])
        switchesStack.axis = .vertical
        switchesStack.distribution = .equalSpacing

        let stack = UIStackView(arrangedSubviews: [labelStack, switchesStack])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally

        minNotificationCell.contentView.addSubview(stack)

        stack.anchor(top: minNotificationCell.topAnchor, left: minNotificationCell.leftAnchor, bottom: minNotificationCell.bottomAnchor, right: minNotificationCell.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 16)

        // Интервал оповещенияя
        notificationIntervalCell.contentView.addSubview(notificationIntervalTextField)
        notificationIntervalTextField.anchor(top: notificationIntervalCell.topAnchor, left: notificationIntervalCell.leftAnchor, bottom: notificationIntervalCell.bottomAnchor, right: notificationIntervalCell.rightAnchor, paddingLeft: 16)

        notificationIntervalPicker.delegate = self
        notificationIntervalPicker.dataSource = self
        notificationIntervalTextField.inputView = notificationIntervalPicker
        notificationIntervalTextField.inputAccessoryView = toolBar

        //
        repeatNotificationsCountCell.contentView.addSubview(repeatNotificationsCountTextField)
        repeatNotificationsCountTextField.anchor(top: repeatNotificationsCountCell.topAnchor, left: repeatNotificationsCountCell.leftAnchor, bottom: repeatNotificationsCountCell.bottomAnchor, right: repeatNotificationsCountCell.rightAnchor, paddingLeft: 16)

        repeatNotificationsPicker.delegate = self
        repeatNotificationsPicker.dataSource = self
        repeatNotificationsCountTextField.inputView = repeatNotificationsPicker
        repeatNotificationsCountTextField.inputAccessoryView = toolBar
    }

    // MARK: - Selectors

    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveButtonTapped() {
    }

    @objc func dismissTextFieldPicker() {
        intergrationWindowTextField.resignFirstResponder()
        failureValueTextField.resignFirstResponder()
        notificationIntervalTextField.resignFirstResponder()
        repeatNotificationsCountTextField.resignFirstResponder()
    }

}

extension SensorsExpertSettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 3
        }

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return intergrationWindowCell
        case 1:
            if indexPath.row == 1 {
                return UITableViewCell()
            }
            if indexPath.row == 2 {
                return minNotificationCell
            }
            if indexPath.row == 3 {
                return maxNotificationCell
            }
            if indexPath.row == 4 {
                return failureNotificationCell
            }
            return failureValueCell

        case 2:
            return notificationIntervalCell
        case 3:
            return repeatNotificationsCountCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            if indexPath.row == 2 {
                return 200
            }
            if indexPath.row == 3 {
                return 80
            }
            if indexPath.row == 4 {
                return 100
            }
            if indexPath.row == 5 {
                return 100
            }
            return 50
        case 2:
            return 50
        case 3:
            return 50
        default:
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Окно интеграции"
        case 1:
            return "Установить значение при аварии"
        case 2:
            return "Интервал оповещения"
        case 3:
            return "Количество повторных оповещений"
        default:
            return ""
        }
    }

}

// MARK: - Extension PickerView Delegate, DataSource

extension SensorsExpertSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch pickerView {
        case intergrationWindowPickerView:
            return intergrationWindowDataSourceArray.count
        case failureValuePickerView:
            return failureValueDataSourceArray.count
        case notificationIntervalPicker:
            return notificationIntervalDataSourceArray.count
        case repeatNotificationsPicker:
            return repeatNotificationsDataSourceArray.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case intergrationWindowPickerView:
            return intergrationWindowDataSourceArray[row]
        case failureValuePickerView:
            return failureValueDataSourceArray[row]
        case notificationIntervalPicker:
            return notificationIntervalDataSourceArray[row]
        case repeatNotificationsPicker:
            return repeatNotificationsDataSourceArray[row]
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case intergrationWindowPickerView:
            intergrationWindowTextField.text = intergrationWindowDataSourceArray[row]
        case failureValuePickerView:
            failureValueTextField.text = failureValueDataSourceArray[row]
        case notificationIntervalPicker:
            notificationIntervalTextField.text = notificationIntervalDataSourceArray[row]
        case repeatNotificationsPicker:
            repeatNotificationsCountTextField.text = repeatNotificationsDataSourceArray[row]
        default:
            break
        }
    }

}
