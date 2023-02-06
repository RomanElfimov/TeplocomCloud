//
//  ExpertBoilerSettingsViewController.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 06.05.2022.
//

import UIKit

final class BoilerExpertSettingsViewController: UIViewController {

    // MARK: - Public Properties

    private(set) var router: ExpertBoilerSettingsRoutingLogic?

    // MARK: - Interface Properties

    private var segmentedControl: CustomSegmentedControl!

    // MARK: - LifeCycle

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
        let router = ExpertBoilerSettingsRouter()

        viewController.router = router
        router.viewController = viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        view.backgroundColor =  .white

        setupNavigationBar()
        configureSegmentControl()

        let relayOneView = RelayOneView()
        view.addSubview(relayOneView)
        relayOneView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)
    }

    private func configureSegmentControl() {
        segmentedControl = CustomSegmentedControl(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: 50),
                                                  buttonTitles: ["Реле 1", "Реле 2", "OpenTherm"])
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectorViewColor = UIColor(named: "TeplocomColor2")!
        segmentedControl.selectorTextColor = UIColor(named: "TeplocomColor2")!
        view.addSubview(segmentedControl)
        segmentedControl.segmentedControlDelegate = self
    }

    private func setupNavigationBar() {
        title = "Экспертный режим"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "TeplocomColor2")
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

    // MARK: - Selector

    @objc func backButtonTapped() {
        router?.dismiss()
    }

}

// MARK: - Segment Control Extension

extension BoilerExpertSettingsViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        switch index {
        case 0:
            let relayOneView = RelayOneView()
            view.addSubview(relayOneView)
            relayOneView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)

        case 1:
            let relayTwoView = RelayTwoView()
            view.addSubview(relayTwoView)
            relayTwoView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)

        case 2:
            let openThermView = OpenThermView()
            view.addSubview(openThermView)
            openThermView.anchor(top: segmentedControl.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8)

        default: break
        }
    }
}
