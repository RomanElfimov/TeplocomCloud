//
//  MenuViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 29.01.2022.
//

import UIKit
import KeychainSwift

final class MenuViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: MenuRoutingLogic?
    private(set) var tableView: UITableView!

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
        let router = MenuRouter()

        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseId)

        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.rowHeight = 90
        tableView.backgroundColor = .white
    }

    private func configurePresentation(with controller: UIViewController) {
        let bindedDevicesVC = controller
        let nav = UINavigationController(rootViewController: bindedDevicesVC)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.tintColor = .white
        present(nav, animated: true, completion: nil)
    }
}

// MARK: - Table View Extension

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseId, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        let menuModel = MenuModel(rawValue: indexPath.row)
        cell.iconImageView.image = menuModel?.image
        cell.myLabel.text = menuModel?.description
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            router?.navigate(to: BindedDevicesViewController())
        case 1:
            router?.navigate(to: PersonalCabinetViewController())
        case 2:
            router?.navigate(to: BoilerManagementViewController())
        case 3:
            router?.navigate(to: AboutDeviceViewController())
        case 4:
            router?.navigate(to: SensorsListViewController())
        case 5:
            let keychain = KeychainSwift(keyPrefix: "Teplocom")
            keychain.clear()

            router?.navigate(to: SignInViewController())
        default:
            break
        }
    }
}
