//
//  ThermostatView.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 02.05.2022.
//

import UIKit

// MARK: - DisplayLogic protocol

protocol ThermostatLogic: AnyObject {
    func displayData(event: ThermostatManagement.Model.ViewModel.ViewModelData)
}

// MARK: - View

final class ThermostatView: UIView {

    // MARK: - Properties

    weak var dismissDelegate: DismissProtocol?
    weak var presentDelegate: PresentProtocol?

    private(set) var router: ThermostatRoutingLogic?

    private var interactor: ThermostatBusinessLogic?

    private var boilerViewModelData = BoilerViewModel(sensorRole: "", setPoint: 0, centralHeatingTemperature: "", roomTemperature: "")
    private let temperatureSettingPickerDataSourceArray = (0...95).map { "\($0)" }
    private var temperatureSetting: Int = 0
    private var sensorRole: String = ""

    // MARK: - Interface Properties

    // Sensor Roler Segment Control
    private(set) var sensorRoleSegmentControl = UISegmentedControl(items: ["Комната", "Теплоноситель"])

    // Current Temperature
    private(set) lazy var currentTemperatureDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Текущая температура:"
        return label
    }()
    private(set) lazy var currentTemperatureValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(named: "TeplocomColor")
        label.text = "25"
        return label
    }()

    // Temperature Setting
    private(set) lazy var temperatureSettingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Уставка температуры:"
        return label
    }()

    private(set) lazy var temperatureSettingPicker = UIPickerView()

    // Comfort / Eco setting buttons
    private(set) lazy var comfortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Комфорт", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.layer.cornerRadius = 10
        button.setDimensions(width: 100, height: 50)
        button.addTarget(self, action: #selector(comfortButtonTapped), for: .touchUpInside)
        return button
    }()

    private(set) lazy var ecoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Эко", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.layer.cornerRadius = 10
        button.setDimensions(width: 100, height: 50)
        button.addTarget(self, action: #selector(ecoButtonTapped), for: .touchUpInside)
        return button
    }()

    // Expert settings button
    private(set) lazy var expertSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Экспертный режим", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "TeplocomColor2")
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(expertSettingsButtonTapped), for: .touchUpInside)
        return button
    }()

    // Bottom view
    private(set) lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TeplocomColor")
        return view
    }()

    private(set) lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Применить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)

        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: 10)
        button.setImage(UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)

        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func layoutSubviews() {
        interactor?.makeRequest(event: .fetchBoilerSettings)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCleanSwift()
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCleanSwift()
    }

    private func setupCleanSwift() {
        let view = self
        let interactor = ThermostatInteractor()
        let presenter = ThermostatPresenter()
        let router = ThermostatRouter()

        view.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = view
        view.router = router
        router.view = view
    }

    // MARK: - Private Methods

    public func setupUI(with model: BoilerViewModel) {
        if model.sensorRole == "indoor" {
            // В комнате
            sensorRoleSegmentControl.selectedSegmentIndex = 0
            currentTemperatureValueLabel.text = model.roomTemperature
        } else {
            // Теплноситель
            sensorRoleSegmentControl.selectedSegmentIndex = 1
            currentTemperatureValueLabel.text = model.centralHeatingTemperature
        }

        temperatureSettingPicker.selectRow(model.setPoint, inComponent: 0, animated: true)
    }

    private func configureUI() {
        backgroundColor = .white

        // Sensor Role Segment Control
        addSubview(sensorRoleSegmentControl)
        sensorRoleSegmentControl.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24, height: 30)
        sensorRoleSegmentControl.addTarget(self, action: #selector(sensorRoleSegmentControlTapped(_:)), for: .valueChanged)

        // Current Temperature
        let currentTemperatureStack = UIStackView(arrangedSubviews: [currentTemperatureDescriptionLabel, currentTemperatureValueLabel])
        currentTemperatureStack.axis = .horizontal
        currentTemperatureStack.distribution = .equalSpacing
        addSubview(currentTemperatureStack)
        currentTemperatureStack.anchor(top: sensorRoleSegmentControl.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 50)

        // Temperature Setting
        addSubview(temperatureSettingDescriptionLabel)
        addSubview(temperatureSettingPicker)

        temperatureSettingDescriptionLabel.anchor(top: currentTemperatureStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 20)
        temperatureSettingPicker.anchor(top: temperatureSettingDescriptionLabel.bottomAnchor, paddingTop: 16, width: 200, height: 150)
        temperatureSettingPicker.centerX(inView: self)
        temperatureSettingPicker.delegate = self
        temperatureSettingPicker.dataSource = self

        // Setting buttons
        let settingButtonsStack = UIStackView(arrangedSubviews: [comfortButton, ecoButton])
        settingButtonsStack.axis = .horizontal
        settingButtonsStack.distribution = .equalSpacing
        addSubview(settingButtonsStack)
        settingButtonsStack.anchor(top: temperatureSettingPicker.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 64, paddingRight: 64, height: 50)

        // Expert Settings Button
        addSubview(expertSettingsButton)
        addSubview(bottomView)

        expertSettingsButton.anchor(bottom: bottomView.topAnchor, paddingBottom: 12)
        expertSettingsButton.setDimensions(width: 200, height: 50)
        expertSettingsButton.centerX(inView: self)

        // Confirm button at bottom
        bottomView.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, height: 70)
        bottomView.addSubview(confirmButton)
        confirmButton.setDimensions(width: 200, height: 50)
        confirmButton.centerY(inView: bottomView)
        confirmButton.centerX(inView: bottomView)
    }

    // MARK: - Selectors

    @objc func expertSettingsButtonTapped() {
        router?.navigateTo(event: .expertSettings)
    }

    @objc func confirmButtonTapped() {
        let parameters: [String: Any] = ["sensorRole": sensorRole, "mode": "thermostat", "setPoint": temperatureSetting]
        interactor?.makeRequest(event: .editBoilerSettings(parameters: parameters))
    }

    @objc func sensorRoleSegmentControlTapped(_ sender: UISegmentedControl!) {
        currentTemperatureValueLabel.text = "-//-"
        switch sender.selectedSegmentIndex {
        case 0:
            sensorRole = "indoor"
            setupUI(with: boilerViewModelData)
            currentTemperatureValueLabel.text = boilerViewModelData.roomTemperature
        case 1:
            sensorRole = "centralHeating"
            currentTemperatureValueLabel.text = boilerViewModelData.centralHeatingTemperature
        default:
            break
        }
    }

    @objc func comfortButtonTapped() {
        temperatureSettingPicker.selectRow(25, inComponent: 0, animated: true)
        temperatureSetting = 25
    }

    @objc func ecoButtonTapped() {
        temperatureSettingPicker.selectRow(12, inComponent: 0, animated: true)
        temperatureSetting = 12
    }

}

// MARK: - Display Logic Extension

extension ThermostatView: ThermostatLogic {
    func displayData(event: ThermostatManagement.Model.ViewModel.ViewModelData) {
        switch event {
        case .displayBoilerSettings(let data):
            setupUI(with: data)
            boilerViewModelData = data

        case .editBoilerSettings(let statusCode):
            if statusCode == 202 {
                router?.navigateTo(event: .dismiss)
            }
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension ThermostatView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temperatureSettingPickerDataSourceArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temperatureSettingPickerDataSourceArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temperatureSetting = Int(temperatureSettingPickerDataSourceArray[row].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
    }
}
