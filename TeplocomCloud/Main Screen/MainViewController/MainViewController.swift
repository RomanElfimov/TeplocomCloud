//
//  MainViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 09.08.2021.
//

import UIKit

enum HotDataConnectionMode: String, CustomStringConvertible {
    case relay1
    case relay2
    case thermostat

    var description: String {
        switch self {
        case .relay1:
            return "relay1"
        case .relay2:
            return "relay2"
        case .thermostat:
            return "thermostat"
        }
    }
}

// MARK: - DisplayLogic protocol

protocol MainScreenDisplayLogic: AnyObject {
    func displayData(event: MainScreen.Model.ViewModel.ViewModelData)
}

// MARK: - Main ViewController

final class MainViewController: UIViewController {

    // MARK: - Public Properties

    var interactor: MainScreenBusinessLogic?

    // MARK: - Private Properties

    private var boilerStateOnOff: Bool = false

    // MARK: - UI Properties

    // Температура на улице
    private(set) var outdoorTemp: UILabel = {
        let label = MainScreenUtilities().createLabel(text: "-5 ˚C")
        label.font = .systemFont(ofSize: 22)
        return label
    }()

    // GSM соединение

    private(set) var gsmDivider = MainScreenUtilities().createDivider()
    private(set) var gsmDescriptionLabel = MainScreenUtilities().createDescriptionLabel(text: "GSM соединение:")

    private(set) var firstGSMImage = MainScreenUtilities().createImage(image: "GSMQuality")
    private(set) var secondGSMImage = MainScreenUtilities().createImage(image: "BatteryLevel")
    private(set) var thirdGSMLabel: UILabel = {
        let label = MainScreenUtilities().createLabel(text: "-/-")
        label.font = .systemFont(ofSize: 22)
        return label
    }()

    // Open Therm подключения

    private(set) var openThermDivider: UIView = MainScreenUtilities().createDivider()
    private(set) var descriptionOTLabel: UILabel = MainScreenUtilities().createDescriptionLabel(text: "Текущие подключения к OpenTherm:")

    private(set) var firstOTImage = MainScreenUtilities().createImage(image: "OpenTherm1")
    private(set) var secondOTImage = MainScreenUtilities().createImage(image: "OpenTherm2")
    private(set) var thirdOTImage = MainScreenUtilities().createImage(image: "OpenTherm3")

    // Функционал котла

    private(set) var separatorKView: UIView = MainScreenUtilities().createDivider()
    private(set) var descriptionKLabel: UILabel = MainScreenUtilities().createDescriptionLabel(text: "Состояне котла")

    private(set) var secondKImage: UIImageView = MainScreenUtilities().createImage(image: "K2")

    private(set) lazy var thirdKLabel: UILabel = {
        let label = MainScreenUtilities().createLabel(text: "-/-")
        label.font = .systemFont(ofSize: 24)
        return label
    }()

    // Температура теплоносителя, комнаты, ГВС:

    private(set) var separatorTView: UIView = MainScreenUtilities().createDivider()
    private(set) var descriptionTLabel: UILabel = MainScreenUtilities().createDescriptionLabel(text: "Температура теплоносителя, комнаты, ГВС:")

    private(set) var firstTLabel: UILabel = MainScreenUtilities().createLabel(text: "-/-")
    private(set) var firstTImage: UIImageView = MainScreenUtilities().createImage(image: "T1")

    private(set) var secondTLabel: UILabel = MainScreenUtilities().createLabel(text: "-/-")
    private(set) var secondTImage: UIImageView = MainScreenUtilities().createImage(image: "T2")

    private(set) var thirdTLabel: UILabel = MainScreenUtilities().createLabel(text: "-/-")
    private(set) var thirdTImage: UIImageView = MainScreenUtilities().createImage(image: "T3")

    // Ручное включение

    private(set) lazy var manualActivationLabel = MainScreenUtilities().createDescriptionLabel(text: "Ручное включение и отключение котла:")
    private(set) lazy var manualActivationButton: UIButton = MainScreenUtilities().createButton(title: "включить")

    // MARK: - Life Cycle

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
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()

        interactor?.makeRequest(event: .fetchHotData)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTimer()
    }

    // MARK: - UI Setup Methods

    // MARK: - Main UI Setup

    private func setupUI() {
        view.backgroundColor = .white

        // GSM соединение
        let gsmInfoStack = createStackView(arrangedSubviews: [gsmDivider, gsmDescriptionLabel], axis: .vertical)
        gsmDescriptionLabel.textAlignment = .center
        let gsmActionStack = createStackView(arrangedSubviews: [firstGSMImage, secondGSMImage, thirdGSMLabel], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        let gsmStack = createStackView(arrangedSubviews: [gsmInfoStack, gsmActionStack], axis: .vertical, spacing: 10)

        // Open Therm подключения
        let openThermInfoStack = createStackView(arrangedSubviews: [openThermDivider, descriptionOTLabel], axis: .vertical)
        let openThermActionStack = createStackView(arrangedSubviews: [firstOTImage, secondOTImage, thirdOTImage], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        let opentThermStack = createStackView(arrangedSubviews: [openThermInfoStack, openThermActionStack], axis: .vertical, spacing: 10)

        // Функционал котла
        let kInfoStack = createStackView(arrangedSubviews: [separatorKView, descriptionKLabel], axis: .vertical)
        let kActionStack = createStackView(arrangedSubviews: [secondKImage, thirdKLabel], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        let kStack = createStackView(arrangedSubviews: [kInfoStack, kActionStack], axis: .vertical, spacing: 10)

        // Температура теплоносителя, комнаты, ГВС:

        let tInfoStack = createStackView(arrangedSubviews: [separatorTView, descriptionTLabel], axis: .vertical)

        let firstTStack = createStackView(arrangedSubviews: [firstTImage, firstTLabel], axis: .vertical, spacing: 4)
        let secondTStack = createStackView(arrangedSubviews: [secondTImage, secondTLabel], axis: .vertical, spacing: 4)
        let thirdTStack = createStackView(arrangedSubviews: [thirdTImage, thirdTLabel], axis: .vertical, spacing: 4)

        let tActionStack = createStackView(arrangedSubviews: [
            firstTStack,
            secondTStack,
            thirdTStack
        ], axis: .horizontal, spacing: 20, distribution: .fillEqually)

        let tStack = createStackView(arrangedSubviews: [tInfoStack, tActionStack], axis: .vertical, spacing: 10)

        // Main Stack

        let stack = createStackView(arrangedSubviews: [
            gsmStack,
            opentThermStack,
            kStack,
            tStack
        ], axis: .vertical, spacing: 30)

        // Ручное включение и отключение котла:
        let manualActivationStack = createStackView(arrangedSubviews: [manualActivationLabel, manualActivationButton], axis: .vertical, spacing: 4)

        view.addSubview(manualActivationStack)
        manualActivationStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 24, paddingBottom: 20, paddingRight: 24)

        manualActivationButton.addTarget(self, action: #selector(manualActivationButtonTapped), for: .touchUpInside)

        // Constraints

        view.addSubview(outdoorTemp)
        view.addSubview(stack)

        outdoorTemp.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        outdoorTemp.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 24, paddingRight: 16)

        stack.anchor(top: outdoorTemp.bottomAnchor, left: view.leftAnchor, bottom: manualActivationStack.topAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 12, paddingRight: 24)

        manualActivationStack.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 24, paddingBottom: 8, paddingRight: 24)
    }

    public func configureUI(with dataModel: HotDataViewModel) {
        firstGSMImage.image = dataModel.simSignalLevel
        secondGSMImage.image = dataModel.batteryVoltage ? UIImage(named: "BatteryLevel") : UIImage(named: "PowerLevel")
        thirdGSMLabel.text = dataModel.simBalance

        firstOTImage.image = UIImage(named: "OpenTherm1")
        secondOTImage.image = UIImage(named: "OpenTherm2")
        thirdOTImage.image = UIImage(named: "OpenTherm3")

        let modeEnum = HotDataConnectionMode(rawValue: dataModel.mode)

        switch modeEnum {
        case .relay1:
            firstOTImage.image = UIImage(named: "OpenTherm1Selected")
        case .relay2:
            secondOTImage.image = UIImage(named: "OpenTherm2Selected")
        case .thermostat:
            thirdOTImage.image = UIImage(named: "OpenTherm3Selected")
        case .none:
            break
        }

        thirdKLabel.text = dataModel.setPoint

        firstTLabel.text = dataModel.centralHeatingTemp
        secondTLabel.text = dataModel.indoorTemp
        thirdTLabel.text = dataModel.domesticHotWaterTemp

        boilerStateOnOff = dataModel.boilerState
        if boilerStateOnOff {
            secondKImage.image = UIImage(named: "K2Selected")
        } else {
            secondKImage.image = UIImage(named: "K2")
        }

        outdoorTemp.text = dataModel.outdoorTemp

        let activationButtonTitle = boilerStateOnOff ? "Отключить" : "включить"
        manualActivationButton.setTitle(activationButtonTitle, for: .normal)
    }

    // MARK: - Helper function

    private func createTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer.tolerance = 500
        timer.fire()
    }

    // MARK: - Helper UI Setup

    private func createStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 14, distribution: UIStackView.Distribution = .fillProportionally) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        return stackView
    }

    private func setupNavigationBar() {
        title = "TEPLOCOM CLOUD"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // background color
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        // title customization
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        navigationItem.standardAppearance = appearance

        // Left Menu button
        let menuImage = UIImage(systemName: "line.3.horizontal")!.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(showMenu))
        navigationItem.leftBarButtonItem = menuButton
    }

    // MARK: - Selectros

    @objc func manualActivationButtonTapped() {
        interactor?.makeRequest(event: .switchBoiler)
    }

    @objc func showMenu() {
        let menuVC = MenuViewController()
        present(menuVC, animated: true, completion: nil)
    }

    @objc func fireTimer() {
        interactor?.makeRequest(event: .fetchHotData)
    }
}

// MARK: - Display Logic Extention

extension MainViewController: MainScreenDisplayLogic {
    func displayData(event: MainScreen.Model.ViewModel.ViewModelData) {
        switch event {
        case .displayHotData(let data):
            configureUI(with: data)

        case .displaySwitchBoiler(statusCode: let statusCode):
            switch statusCode {
            case 202:
                boilerStateOnOff.toggle()

                if boilerStateOnOff {
                    secondKImage.image = UIImage(named: "K2Selected")
                } else {
                    secondKImage.image = UIImage(named: "K2")
                }

                let activationButtonTitle = boilerStateOnOff ? "Отключить" : "включить"
                manualActivationButton.setTitle(activationButtonTitle, for: .normal)
            default:
                showAlert(with: "Произошла ошибка", and: "Попробуйте снова")
            }

        }
    }
}
