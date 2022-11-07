//
//  OpenThermView.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.05.2022.
//

import UIKit

// MARK: - Display Logic protocol

protocol OpenThermDisplayLogic: AnyObject {
    func displayData(event: OpenTherm.Model.ViewModel.ViewModelData)
}

final class OpenThermView: UIView {

    // MARK: - Properties

    private var interactor: OpenThermBusinessLogic?
    private var configurationDomesticHotWater: String = ""

    // MARK: - Interface Properties

    // Table View
    let tableView = UITableView()

    // Title
    private lazy var titleCell = createCell()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки управления котлом по протоколу OpenTherm"
        label.numberOfLines = 0
        return label
    }()

    // Max GVS
    private lazy var maxGVSTempCell = createCell()
    private lazy var maxGVSTempDescriptionLabel = createDescriptionLabel(with: "Максимальная температура ГВС:")
    private lazy var maxGVSSlider = createSlider()
    private lazy var maxGVSMinLabel = createMinLabel()
    private lazy var maxGVSMaxLabel = createMaxLabel()

    // Min GVS
    private lazy var minGVSTempCell = createCell()
    private lazy var minGVSTempDescriptionLabel = createDescriptionLabel(with: "Минимальная температура ГВС:")
    private lazy var minGVSSlider = createSlider()
    private lazy var minGVSMinLabel = createMinLabel()
    private lazy var minGVSMaxLabel = createMaxLabel()

    // GVS Setting
    private lazy var gvsSettingCell = createCell()
    private lazy var gvsSettingDescriptionLabel = createDescriptionLabel(with: "Уставка ГВС:")
    private lazy var gvsSettingSlider = createSlider()
    private lazy var gvsSettingMinLabel = createMinLabel()
    private lazy var gvsSettingMaxLabel = createMaxLabel()

    // Boiler Temperature - min, max
    private lazy var minboilerTempCell = createCell()
    private lazy var minboilerTempDescriptionLabel = createDescriptionLabel(with: "Минимальная температура теплоносителя:")
    private lazy var minboilerTempSlider = createSlider()
    private lazy var minboilerTempMinLabel = createMinLabel()
    private lazy var minboilerTempMaxLabel = createMaxLabel()

    private lazy var maxboilerTempCell = createCell()
    private lazy var maxboilerTempDescriptionLabel = createDescriptionLabel(with: "Максимальная температура теплоносителя:")
    private lazy var maxboilerTempSlider = createSlider()
    private lazy var maxboilerTempMinLabel = createMinLabel()
    private lazy var maxboilerTempMaxLabel = createMaxLabel()

    // Burner Modulation
    private lazy var burnerModulationCell = createCell()
    private lazy var burnerModulationDescriptionLabel = createDescriptionLabel(with: "Максимальная модуляция горелки:")
    private lazy var burnerModulationSlider = createSlider()
    private lazy var burnerModulationMinLabel = createMinLabel()
    private lazy var burnerModulationMaxLabel = createMaxLabel()

    // GVS Configuration
    private lazy var relayCell = createCell()

    private lazy var relayDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Конфигурация ГВС:"
        return label
    }()

    private lazy var relayImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 40, height: 40)
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "GVSConfigurationImage")
        return iv
    }()

    private lazy var openRelayLabel: UILabel = {
        let label = UILabel()
        label.text = "Проточный водонагреватель"
        return label
    }()

    private lazy var openRelayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        button.addTarget(self, action: #selector(openRelayButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var closeRelayLabel: UILabel = {
        let label = UILabel()
        label.text = "Бойлер косвенного нагрева"
        return label
    }()

    private lazy var closeRelayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        button.addTarget(self, action: #selector(closeRelayButtonTapped), for: .touchUpInside)
        return button
    }()

    // Save Button
    private lazy var saveCell = createCell()
    private lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Сохранить", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(named: "TeplocomColor2")
        btn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return btn
    }()

    // MARK: - Life Cycle

    override func layoutSubviews() {
        interactor?.makeRequest(event: .fetchOpenThermSettings)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCleanSwift()
        backgroundColor = .white
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCleanSwift()
    }

    private func setupCleanSwift() {
        let view = self
        let interactor = OpenThermInteractor()
        let presenter = OpenThermPresenter()

        view.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = view
    }

    // MARK: - Private Methods

    private func setupUI(with model: BoilerOpenThermSettingsBackendModel) {
        DispatchQueue.main.async {
            self.maxGVSSlider.setValue(Float(model.maxDomesticHotWaterTemperature), animated: true)
            self.minGVSSlider.setValue(Float(model.minDomesticHotWaterTemperature), animated: true)
            self.gvsSettingSlider.setValue(Float(model.setPointDomesticHotWater), animated: true)
            self.minboilerTempSlider.setValue(Float(model.minHeatingMediumTemperature), animated: true)
            self.maxboilerTempSlider.setValue(Float(model.maxHeatingMediumTemperature), animated: true)
            self.burnerModulationSlider.setValue(Float(model.maximumBurnerModulation), animated: true)
        }

        let uncheckImage = UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!)
        let checkImage = UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!)
        configurationDomesticHotWater = model.configurationDomesticHotWater
        if model.configurationDomesticHotWater == "instantaneousWaterHeater" {
            openRelayButton.setImage(checkImage, for: .normal)
            closeRelayButton.setImage(uncheckImage, for: .normal)
        } else {
            openRelayButton.setImage(uncheckImage, for: .normal)
            closeRelayButton.setImage(checkImage, for: .normal)
        }
    }

    private func configureUI() {

        backgroundColor = .white

        // Table View
        addSubview(tableView)
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        tableView.delegate = self
        tableView.dataSource = self

        // Title
        titleCell.contentView.addSubview(titleLabel)
        titleLabel.anchor(top: titleCell.topAnchor, left: titleCell.leftAnchor, bottom: titleCell.bottomAnchor, right: titleCell.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)

        // GVS - max, min
        configureCell(cell: maxGVSTempCell, descriptionLabel: maxGVSTempDescriptionLabel, slider: maxGVSSlider, minLabel: maxGVSMinLabel, maxLabel: maxGVSMaxLabel)

        configureCell(cell: minGVSTempCell, descriptionLabel: minGVSTempDescriptionLabel, slider: minGVSSlider, minLabel: minGVSMinLabel, maxLabel: minGVSMaxLabel)

        // GVS Setting
        configureCell(cell: gvsSettingCell, descriptionLabel: gvsSettingDescriptionLabel, slider: gvsSettingSlider, minLabel: gvsSettingMinLabel, maxLabel: gvsSettingMaxLabel)

        // Boiler Temperature - min, max
        configureCell(cell: minboilerTempCell, descriptionLabel: minboilerTempDescriptionLabel, slider: minboilerTempSlider, minLabel: minboilerTempMinLabel, maxLabel: minboilerTempMaxLabel)

        configureCell(cell: maxboilerTempCell, descriptionLabel: maxboilerTempDescriptionLabel, slider: maxboilerTempSlider, minLabel: maxboilerTempMinLabel, maxLabel: maxboilerTempMaxLabel)

        // Burner Modulation
        configureCell(cell: burnerModulationCell, descriptionLabel: burnerModulationDescriptionLabel, slider: burnerModulationSlider, minLabel: burnerModulationMinLabel, maxLabel: burnerModulationMaxLabel)

        // GVS Configuration
        let openRelayStack = UIStackView(arrangedSubviews: [openRelayLabel, openRelayButton])
        openRelayStack.axis = .horizontal
        openRelayStack.distribution = .equalCentering

        let closeRelayStack = UIStackView(arrangedSubviews: [closeRelayLabel, closeRelayButton])
        closeRelayStack.axis = .horizontal
        closeRelayStack.distribution = .equalCentering

        let relayActionStack = UIStackView(arrangedSubviews: [openRelayStack, closeRelayStack])
        relayActionStack.axis = .vertical
        relayActionStack.spacing = 16
        relayActionStack.distribution = .equalCentering

        let relayStack = UIStackView(arrangedSubviews: [relayImageView, relayActionStack])
        relayStack.axis = .horizontal
        relayStack.spacing = 16
        relayStack.distribution = .fillProportionally

        relayCell.contentView.addSubview(relayStack)
        relayCell.contentView.addSubview(relayDescriptionLabel)

        relayDescriptionLabel.anchor(top: relayCell.topAnchor, left: relayCell.leftAnchor, right: relayCell.rightAnchor, paddingTop: 12, paddingLeft: 8, paddingRight: 8, height: 25)

        relayStack.anchor(top: relayDescriptionLabel.bottomAnchor, left: relayCell.leftAnchor, bottom: relayCell.bottomAnchor, right: relayCell.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 24, paddingRight: 16)

        maxGVSSlider.addTarget(self, action: #selector(actionTapped(sender:)), for: .touchUpInside)

        // Save Button
        saveCell.contentView.addSubview(saveButton)
        saveButton.anchor(top: saveCell.topAnchor, left: saveCell.leftAnchor, bottom: saveCell.bottomAnchor, right: saveCell.rightAnchor, paddingTop: 26, paddingLeft: 56, paddingBottom: 26, paddingRight: 56)
        saveButton.layer.cornerRadius = 20
    }

    private func createCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }

    private func createDescriptionLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }

    private func createSlider() -> UISlider {
        let slider = ThumbTemperatureSlider()
        slider.minValue = 0
        slider.maxValue = 95
        slider.trackColor = UIColor(named: "TeplocomColor2")
        return slider
    }

    private func createMinLabel() -> UILabel {
        let label = UILabel()
        label.text = "0˚"
        return label
    }

    private func createMaxLabel() -> UILabel {
        let label = UILabel()
        label.text = "95˚"
        return label
    }

    private func configureCell(cell: UITableViewCell, descriptionLabel: UILabel, slider: UISlider, minLabel: UILabel, maxLabel: UILabel) {

        cell.contentView.addSubview(descriptionLabel)
        cell.contentView.addSubview(slider)

        let stack = UIStackView(arrangedSubviews: [minLabel, maxLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        cell.contentView.addSubview(stack)

        descriptionLabel.anchor(top: cell.topAnchor, left: cell.leftAnchor, bottom: slider.topAnchor, right: cell.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)

        slider.anchor(top: descriptionLabel.bottomAnchor, left: cell.leftAnchor, bottom: stack.topAnchor, right: cell.rightAnchor, paddingTop: 12, paddingLeft: 20, paddingBottom: 4, paddingRight: 20)

        stack.anchor(top: slider.bottomAnchor, left: cell.leftAnchor, bottom: cell.bottomAnchor, right: cell.rightAnchor, paddingTop: 4, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
    }

    private func setAlert(with title: String, and description: String) {
        let alertView = ConnectionAlertView(frame: UIScreen.main.bounds, title: title, description: description)

        addSubview(alertView)
    }

    // MARK: - Selectors

    @objc func actionTapped(sender: UISlider) {
        print(sender.value)
    }

    @objc func saveButtonTapped() {
        let parameters: [String: Any] = ["maxDomesticHotWaterTemperature": Int(maxGVSSlider.value) * 100,
                                         "minDomesticHotWaterTemperature": Int(minGVSSlider.value) * 100,
                                         "setPointDomesticHotWater": Int(gvsSettingSlider.value) * 100,
                                         "maxHeatingMediumTemperature": Int(maxboilerTempSlider.value) * 100, "minHeatingMediumTemperature": Int(minboilerTempSlider.value) * 100,
                                         "maximumBurnerModulation": burnerModulationSlider.value, "configurationDomesticHotWater": configurationDomesticHotWater]
        interactor?.makeRequest(event: .editOpenThermSettings(parameters: parameters))
    }

    @objc func openRelayButtonTapped() {
        configurationDomesticHotWater = "instantaneousWaterHeater"
        openRelayButton.setImage(UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        closeRelayButton.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
    }

    @objc func closeRelayButtonTapped() {
        configurationDomesticHotWater = "indirectHeatingBoiler"
        openRelayButton.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        closeRelayButton.setImage(UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
    }
}

// MARK: - Display Logic Extension

extension OpenThermView: OpenThermDisplayLogic {
    func displayData(event: OpenTherm.Model.ViewModel.ViewModelData) {
        switch event {
        case .fetchOpenThermSettings(data: let data):
            setupUI(with: data)
        case .editOpenThermSettings(let statusCode):
            var title: String = ""
            var description: String = ""

            switch statusCode {
            case 202:
                title = "Успешно"
                description = "Задача поставлена в работу"
            case 400:
                title = "Ошибка"
                description = "Неправильно переданы входные параметры"
            case 404:
                title = "Ошибка"
                description = "Устройство отсутствует"

            default:
                title = "Ошибка"
                description = "Произошла неизвестная ошибка"
            }

            setAlert(with: title, and: description)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource Extension

extension OpenThermView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return titleCell
        case 1: return maxGVSTempCell
        case 2: return minGVSTempCell
        case 3: return gvsSettingCell
        case 4: return minboilerTempCell
        case 5: return maxboilerTempCell
        case 6: return burnerModulationCell
        case 7: return relayCell
        case 8: return saveCell

        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 150
        }
        return 110
    }
}
