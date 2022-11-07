//
//  BindedDevicesViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.02.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol BindedDevicesDispayLogic: AnyObject {

    func displayData(event: BindedDevices.Model.ViewModel.ViewModelData)
}

// MARK: - ViewController class

final class BindedDevicesViewController: UIViewController {

    // MARK: - Public Properties

    public var bindedDevicesArray: [BindedDevicesViewModel] = []
    public var tableView = UITableView(frame: .zero)

    public var interactor: (BindedDevicesBusinessLogic & BindedDevicesStoreProtocol)?
    private(set) var router: (BindedDevicesRoutingLogic & BindedDevicesDataPassingProtocol)?

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
        let interactor = BindedDevicesInteractor()
        let presenter = BindedDevicesPresenter()
        let router = BindedDevicesRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        viewController.router = router
        router.dataStore = interactor
        router.viewController = viewController
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureTableView()
        setupNavigationBar()

        interactor?.makeRequest(event: .fetchBindedDevices)
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BindedDevicesTableViewCell.self, forCellReuseIdentifier: BindedDevicesTableViewCell.cellIdentifier)

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.backgroundColor = .white
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

        // Back Button Arrow
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    }

    // MARK: - Selectors

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Display Logic Extension

extension BindedDevicesViewController: BindedDevicesDispayLogic {
    func displayData(event: BindedDevices.Model.ViewModel.ViewModelData) {
        switch event {

        case .displayBindedDevices(let data):
            bindedDevicesArray = data
            tableView.reloadData()
        }
    }
}

// MARK: - TableView Extension

extension BindedDevicesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bindedDevicesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BindedDevicesTableViewCell.cellIdentifier, for: indexPath) as? BindedDevicesTableViewCell else { return UITableViewCell() }
        cell.setup(with: bindedDevicesArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deviceUID = bindedDevicesArray[indexPath.row].uid

        let defaults = UserDefaults.standard
        defaults.set(deviceUID, forKey: "DeviceUID")

        router?.navigateToMain()
    }
}
