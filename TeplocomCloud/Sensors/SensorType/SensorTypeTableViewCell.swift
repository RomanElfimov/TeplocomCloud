//
//  SensorTypeTableViewCell.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 22.03.2022.
//

import UIKit

final class SensorTypeTableViewCell: UITableViewCell {

    // MARK: - Reuse ID

    static let reuseId = "Cell"

    // MARK: - Properties

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 44, height: 44)
        return imageView
    }()

    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: "TeplocomColor")
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(iconImageView)
        addSubview(myLabel)

        backgroundColor = .clear

        myLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: iconImageView.leftAnchor, paddingTop: 4, paddingLeft: 24, paddingBottom: 4, paddingRight: 12)

        iconImageView.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 4, paddingRight: 24)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
