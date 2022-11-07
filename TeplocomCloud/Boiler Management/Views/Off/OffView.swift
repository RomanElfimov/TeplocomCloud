//
//  OffView.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 02.05.2022.
//

import UIKit

// MARK: - Display logic protocol

protocol OffViewDisplayLogic: AnyObject {
    func displayData(event: OffViewModel.Model.ViewModel.ViewModelData)
}

// MARK: - View class

final class OffView: UIView {

    // MARK: - Public Properties

    weak var dismissDelegate: DismissProtocol?
    private(set) var router: OffViewRoutingLogic?

    // MARK: - Private Properties

    private var interactor: OffViewBusinessLogic?

    // MARK: - Interface Properties

    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Полное выключение тепловой системы (например в летний период)."
        label.textColor = UIColor(named: "TeplocomColor")
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "OffBoilerImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    // Bottom view

    private(set) lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TeplocomColor")
        return view
    }()

    private(set) lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Применить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)

        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: 10)
        button.setImage(UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)

        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        setupCleanSwift()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCleanSwift()
    }

    private func setupCleanSwift() {
        let view = self
        let interactor = OffViewInteractor()
        let presenter = OffViewPresenter()
        let router = OffViewRouter()

        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        view.router = router
        router.view = view
    }

    // MARK: - Private Methods

    private func configureUI() {
        backgroundColor = .white
        addSubview(descriptionLabel)
        addSubview(imageView)

        descriptionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: imageView.topAnchor, right: rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)

        imageView.centerX(inView: self)
        imageView.setDimensions(width: 200, height: 250)

        addSubview(bottomView)
        bottomView.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, height: 70)
        bottomView.addSubview(confirmButton)
        confirmButton.setDimensions(width: 200, height: 50)
        confirmButton.centerY(inView: bottomView)
        confirmButton.centerX(inView: bottomView)
    }

    // MARK: - Selector

    @objc func confirmButtonTapped() {
        interactor?.makeRequest(event: .editBoilerSettings(parameters: ["boilerState": true]))
    }
}

// MARK: - Extension DisplayLogic

extension OffView: OffViewDisplayLogic {
    func displayData(event: OffViewModel.Model.ViewModel.ViewModelData) {
        switch event {
        case .editBoilerSettings(let statusCode):

            if statusCode == 202 {
                router?.dismiss()
            }
        }
    }
}
