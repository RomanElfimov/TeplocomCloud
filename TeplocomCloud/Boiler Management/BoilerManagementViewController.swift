//
//  BoilerManagementViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 02.05.2022.
//

import UIKit

// MARK: - Dismiss Protocol

protocol DismissProtocol: AnyObject {
    func hideBoilerView()
}

// MARK: - Present Protocol

protocol PresentProtocol: AnyObject {
    func presentController(with controller: UIViewController)
}

// MARK: - View Controller

final class BoilerManagementViewController: UIViewController {

    // MARK: - Properties

    private var interactor: ThermostatBusinessLogic?
    private(set) var router: BoilerManagementRoutingLogic?

    // MARK: - Interface Properties

    private var segmentedControl: CustomSegmentedControl!

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
        let router = BoilerManagementRouter()
        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        interactor?.makeRequest(event: .fetchBoilerSettings)

        configureSegmentControl()

        let thermView = ThermostatView()
        view.addSubview(thermView)

        thermView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)
        thermView.dismissDelegate = self
        thermView.presentDelegate = self

        setupNavigationBar()
    }

    // MARK: - Private Methods

    private func configureSegmentControl() {
        segmentedControl = CustomSegmentedControl(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: 50),
                                                  buttonTitles: ["Термостат", "Ручное", "Выкл."])
        segmentedControl.backgroundColor = .clear
        view.addSubview(segmentedControl)
        segmentedControl.segmentedControlDelegate = self
    }

    private func configureView(with customView: UIView) {

        view.addSubview(customView)
        customView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)
    }

    private func setupNavigationBar() {
        title = "Управление котлом"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TeplocomColor")
        // title customization
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.standardAppearance = appearance

        // Back button
        let backImage = UIImage(systemName: "chevron.left")!.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    // MARK: - Selectors

    @objc func backButtonTapped() {
        router?.dismiss()
    }

}

// MARK: - Segment Control Extension

extension BoilerManagementViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {

        switch index {
        case 0:

            let thermView = ThermostatView()
            view.addSubview(thermView)
            thermView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)
            thermView.presentDelegate = self
            thermView.dismissDelegate = self
        case 1:

            let handleView = HandleView()
            view.addSubview(handleView)
            handleView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)
            handleView.dismissDelegate = self
        case 2:

            let offView = OffView()
            view.addSubview(offView)
            offView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)
            offView.dismissDelegate = self

        default:
            break
        }
    }
}

// MARK: - Dismiss Protocol Extension

extension BoilerManagementViewController: DismissProtocol {
    func hideBoilerView() {
        dismiss(animated: true)
    }
}

// MARK: - Present Protocol Extension

extension BoilerManagementViewController: PresentProtocol {
    func presentController(with controller: UIViewController) {
        present(controller, animated: true)
    }
}
