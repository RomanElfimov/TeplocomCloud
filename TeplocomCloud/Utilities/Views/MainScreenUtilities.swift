//
//  MainScreenUtilities.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 29.01.2022.
//

import UIKit

final class MainScreenUtilities {

    // MARK: - Public Methods

    public func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = UIColor(named: "TeplocomColor")
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }

    public func createImage(image: String, isDisable: Bool? = false) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(lessThanOrEqualToConstant: 35).isActive = true
        iv.heightAnchor.constraint(lessThanOrEqualToConstant: 45).isActive = true
        iv.image = UIImage(named: image)
        return iv
    }

    public func createDescriptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.textColor = UIColor(named: "TeplocomColor")
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }

    public func createDivider() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "TeplocomColor")
        separatorView.setDimensions(width: 100, height: 1)
        separatorView.translatesAutoresizingMaskIntoConstraints  = false
        return separatorView
    }

    public func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title.uppercased(), for: .normal)
        button.backgroundColor = UIColor(named: "TeplocomColor")
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setDimensions(width: 777, height: 60)
        button.layer.cornerRadius = 15
        return button
    }
}
