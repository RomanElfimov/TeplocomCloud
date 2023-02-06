//
//  SensorLoaderViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol SensorLoaderDisplayLogic: AnyObject {
    func displayData(event: SensorLoader.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller

final class SensorLoaderViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: SensorLoaderRoutingLogic?

    // MARK: - Private Properties

    private var interactor: SensorLoaderBusinessLogic?

    private var timer: Timer?
    private let imagesArray: [UIImage] = [UIImage(named: "1")!,
                                          UIImage(named: "2")!,
                                          UIImage(named: "3")!,
                                          UIImage(named: "4")!,
                                          UIImage(named: "5")!,
                                          UIImage(named: "6")!,
                                          UIImage(named: "7")!,
                                          UIImage(named: "8")!,
                                          UIImage(named: "9")!]

    // MARK: - Interface Properties

    // descriptionLabel
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Идет проверка подключенных к устройству датчиков... \nПодключите датчик к устройству"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "TeplocomColor")
        label.textAlignment = .center
        return label
    }()

    // loaderImageView
    private let loaderImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

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
        let interactor = SensorLoaderInteractor()
        let presenter = SensorLoaderPresenter()
        let router = SensorLoaderRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createTimer()

        loaderImageView.animationImages = imagesArray
        self.loaderImageView.animationDuration = 1.0
        self.loaderImageView.animationRepeatCount = 0
        self.loaderImageView.startAnimating()

        // mock server response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.interactor?.makeRequest(event: .fetchUnallocatedSensor)
        }

    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(loaderImageView)
        loaderImageView.center(inView: view)
        loaderImageView.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)

        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: loaderImageView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 8, paddingRight: 12)
    }

    private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            timer?.tolerance = 200
            timer?.fire()
        }
    }

    // MARK: - Selectors

    @objc func fireTimer() {
        interactor?.makeRequest(event: .fetchUnallocatedSensor)
    }

}

// MARK: - Display Logic Extension

extension SensorLoaderViewController: SensorLoaderDisplayLogic {
    func displayData(event: SensorLoader.Model.ViewModel.ViewModelData) {
        switch event {
        case .displayUnallocatedSensor(let result):

            if result.found {
                router?.navigateToSensorType()
                timer?.invalidate()
            }
        }
    }
}
