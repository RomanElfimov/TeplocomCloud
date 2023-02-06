//
//  SensorsListViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import UIKit

// MARK: - Display Logic Protocol

protocol SensorsListDisplayLogic: AnyObject {
    func displayData(event: SensorsList.Model.ViewModel.ViewModelData)
}

// MARK: - View Controller Class

final class SensorsListViewController: UIViewController {

    // MARK: - Public Properties

    public var sensorsListDataSource: [TemperatureSensorsListBackendModel] = []
    public var tableView = UITableView(frame: .zero)
    private(set) var router: SensorsListRoutingLogic?

    // MARK: - Private Properties

    private var interactor: SensorsListBusinessLogic?

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
        let interactor = SensorsListInteractor()
        let presenter = SensorsListPresenter()
        let router = SensorsListRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        viewController.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        configureTableView()
        view.backgroundColor = .white

        interactor?.makeRequest(event: .fetchSensorsList)
    }

    // MARK: - Private Method

    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SensorsListTableViewCell.self, forCellReuseIdentifier: SensorsListTableViewCell.cellIdentifier)

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        tableView.backgroundColor = .white
    }

    private func setupNavigationBar() {
        title = "Список датчиков"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // background color
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        // title customization
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance

        // Right bar button
        let addSensorImage = UIImage(systemName: "plus")!.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let addSensorButton = UIBarButtonItem(image: addSensorImage, style: .plain, target: self, action: #selector(addSensor))
        navigationItem.rightBarButtonItem = addSensorButton

        // Left bar button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    }

    // MARK: - Selectors

    @objc func addSensor() {
        router?.navigateTo(navigateType: .addNewSensor)
    }

    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - TableView Extension

extension SensorsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorsListDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SensorsListTableViewCell.cellIdentifier, for: indexPath) as? SensorsListTableViewCell else { return UITableViewCell() }

        cell.setup(with: sensorsListDataSource[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sensor = sensorsListDataSource[indexPath.row]
        router?.navigateTo(navigateType: .editSensor(sensorType: sensor.role, sensorID: sensor.id))
    }

    // Working with sections

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Температурный датчик"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        header.textLabel?.font = UIFont.systemFont(ofSize: 20)
        header.textLabel?.frame = header.bounds

    }
}

// MARK: - DisplayLogic Extension

extension SensorsListViewController: SensorsListDisplayLogic {
    func displayData(event: SensorsList.Model.ViewModel.ViewModelData) {
        switch event {

        case .displaySensorsList(let data):
            sensorsListDataSource = data
            tableView.reloadData()
        }
    }
}
