//
//  SensorTypeViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

final class SensorTypeViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: SensorTypeRoutingLogic?

    // MARK: - Private Properties

    private var tableView: UITableView!

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
        let router = SensorTypeRouter()

        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
        configureTableView()
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SensorTypeTableViewCell.self, forCellReuseIdentifier: SensorTypeTableViewCell.reuseId)

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        tableView.backgroundColor = .white
    }

    private func setupNavigationBar() {
        title = "Новый датчик"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance

        // Left bar button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")!.withRenderingMode(.alwaysOriginal).withTintColor(.white), style: .plain, target: self, action: #selector(backButtonTapped))
    }

    // MARK: - Selectors

    @objc func backButtonTapped() {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

// MARK: - Table View Extension

extension SensorTypeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SensorTypeTableViewCell.reuseId, for: indexPath) as?  SensorTypeTableViewCell else { return UITableViewCell() }

        let sensorType = SensorTypeModel(rawValue: indexPath.row)
        cell.iconImageView.image = sensorType?.image
        cell.myLabel.text = sensorType?.description

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.navigateToSensorSettings(sensorType: SensorTypeModel(rawValue: indexPath.row)?.description ?? "")
    }

    // Header

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Выберите тип датчика:"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.frame = CGRect(x: 20, y: 8, width: 320, height: 40)
        header.textLabel?.font = UIFont.systemFont(ofSize: 20)
        header.textLabel?.frame = header.bounds

    }

}
