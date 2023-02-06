//
//  RelayTwoView.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 11.05.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol RelayTwoDisplayLogic: AnyObject {
    func displayData(event: RelayOne.Model.ViewModel.ViewModelData)
}

// MARK: - View class

final class RelayTwoView: UIView {

    // MARK: - Properties

    private var interactor: RelayTwoBusinessLogic?
    private var normalState: String = ""

    // MARK: - Interface Properties

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        return table
    }()

    // Title
    private lazy var titleCell = createCell()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Управление котлом через релейный выход №2"
        label.numberOfLines = 0
        return label
    }()

    // Relay choise
    private lazy var relayCell = createCell()

    private lazy var relayDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Тип контактов реле:"
        return label
    }()

    private lazy var relayImageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 30, height: 30)
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Relay2Image")
        return iv
    }()

    private lazy var openRelayLabel: UILabel = {
        let label = UILabel()
        label.text = "Нормально открытые (НО)"
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
        label.text = "Нормально закрытые (НЗ)"
        return label
    }()

    private lazy var closeRelayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        button.addTarget(self, action: #selector(closeRelayButtonTapped), for: .touchUpInside)
        return button
    }()

    // Circular pump
    private lazy var circularPumpCell = createCell()
    private lazy var circularPumpDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Включение циркулярного насоса:"
        return label
    }()
    private let circularPumpSlider: ThumbTemperatureSlider = {
        let slider = ThumbTemperatureSlider()
        slider.minValue = 0
        slider.maxValue = 30
        return slider
    }()
    private lazy var minCircularPumpLabel: UILabel = {
        let label = UILabel()
        label.text = "0 мин."
        return label
    }()
    private lazy var maxCircularPumpLabel: UILabel = {
        let label = UILabel()
        label.text = "30 мин."
        return label
    }()

    // Hysteresis
    private lazy var hysteresisCell = createCell()
    private lazy var hysteresisDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Гистерезис:"
        return label
    }()
    private let hysteresisSlider: ThumbTemperatureSlider = {
        let slider = ThumbTemperatureSlider()
        slider.minValue = 0
        slider.maxValue = 30
        return slider
    }()
    private lazy var minHysteresisLabel: UILabel = {
        let label = UILabel()
        label.text = "0˚"
        return label
    }()
    private lazy var maxhysteresisPumpLabel: UILabel = {
        let label = UILabel()
        label.text = "30˚"
        return label
    }()

    // Off Boiler
    private lazy var offBoilerCell = createCell()
    private lazy var offBoilerLabel: UILabel = {
        let label = UILabel()
        label.text = "Отключение котла по командам контактного датчика:"
        label.numberOfLines = 0
        return label
    }()
    private lazy var offBoilerSwitch: UISwitch = {
        let offSwitch = UISwitch()
        return offSwitch
    }()

    // Save
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
        interactor?.makeRequest(event: .fetchExpertSettings)
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
        let interactor = RelayTwoInteractor()
        let presenter = RelayTwoPresenter()

        view.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = view
    }

    // MARK: - Private Methods

    private func setupUI(with model: BoilerExpertSettingsViewModel) {
        // Тип контактов реле:
        normalState = model.normalState ?? ""
        let uncheckImage = UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!)
        let checkImage = UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!)
        if model.normalState == "normalOpened" {
            openRelayButton.setImage(checkImage, for: .normal)
            closeRelayButton.setImage(uncheckImage, for: .normal)
        } else {
            openRelayButton.setImage(uncheckImage, for: .normal)
            closeRelayButton.setImage(checkImage, for: .normal)
        }

        DispatchQueue.main.async {
            // Включение циркулярного насоса
            self.circularPumpSlider.setValue(model.switchingOnTheBoilerCirculationPump, animated: true)

            // Гистерезиз
            self.hysteresisSlider.setValue(model.hysteresis, animated: true)
        }

        // Отключение котла по командам датчика
        offBoilerSwitch.isOn = model.stateOnLeakage
    }

    private func configureUI() {
        backgroundColor = .white

        // Table View
        addSubview(tableView)
        tableView.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self

        // Title
        titleCell.contentView.addSubview(titleLabel)
        titleLabel.anchor(top: titleCell.topAnchor, left: titleCell.leftAnchor, bottom: titleCell.bottomAnchor, right: titleCell.rightAnchor, paddingTop: 24, paddingLeft: 12, paddingBottom: 12, paddingRight: 12)

        // Relay Choise
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

        relayStack.anchor(top: relayDescriptionLabel.bottomAnchor, left: relayCell.leftAnchor, bottom: relayCell.bottomAnchor, right: relayCell.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 18, paddingRight: 16)

        // Circular pump
        createSliderUI(cell: circularPumpCell, descriptionLabel: circularPumpDescriptionLabel, slider: circularPumpSlider, minLabel: minCircularPumpLabel, maxLabel: maxCircularPumpLabel)

        // Hysteresis
        createSliderUI(cell: hysteresisCell, descriptionLabel: hysteresisDescriptionLabel, slider: hysteresisSlider, minLabel: minHysteresisLabel, maxLabel: maxhysteresisPumpLabel)

        // Off Boiler
        offBoilerCell.contentView.addSubview(offBoilerLabel)
        offBoilerCell.contentView.addSubview(offBoilerSwitch)

        offBoilerLabel.anchor(top: offBoilerCell.topAnchor, left: offBoilerCell.leftAnchor, bottom: offBoilerCell.bottomAnchor, right: offBoilerSwitch.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 8)
        offBoilerSwitch.anchor(right: offBoilerCell.rightAnchor, paddingRight: 12)
        offBoilerSwitch.centerY(inView: offBoilerCell)

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

    private func createSliderUI(cell: UITableViewCell, descriptionLabel: UILabel, slider: UISlider, minLabel: UILabel, maxLabel: UILabel) {

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

    @objc func saveButtonTapped() {
        let parameters: [String: Any] = ["boilerControlProtocol": "relay2",
                                         "hysteresis": Int(hysteresisSlider.value) * 100,
                                         "normalState": normalState,
                                         "stateOnLeakage": offBoilerSwitch.isOn,
                                         "switchingOnTheBoilerCirculationPump": Int(circularPumpSlider.value) * 60]
        interactor?.makeRequest(event: .editExpertSettings(parameters: parameters))
    }

    @objc func openRelayButtonTapped() {
        normalState = "normalOpened"
        openRelayButton.setImage(UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        closeRelayButton.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
    }

    @objc func closeRelayButtonTapped() {
        normalState = "normalClosed"
        openRelayButton.setImage(UIImage(systemName: "circle.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
        closeRelayButton.setImage(UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "TeplocomColor2")!), for: .normal)
    }
}

// MARK: - Display Logic Extension

extension RelayTwoView: RelayTwoDisplayLogic {
    func displayData(event: RelayOne.Model.ViewModel.ViewModelData) {
        switch event {
        case .fetchExpertSettings(data: let data):

            if data.boilerControlProtocol == "relay2" {
                setupUI(with: data)
            }

        case .editExpertSettings(statusCode: let statusCode):
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

extension RelayTwoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return titleCell
        case 1: return relayCell
        case 2: return circularPumpCell
        case 3: return hysteresisCell
        case 4: return offBoilerCell
        case 5: return saveCell

        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 100
        case 1: return 140
        case 2: return 110
        case 3: return 110
        case 4: return 110
        case 5: return 110

        default: return 0
        }
    }
}
