//
//  SensorsListTableViewCell.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 20.02.2022.
//

import UIKit

final class SensorsListTableViewCell: UITableViewCell {

    // MARK: - Reuse ID

    static let cellIdentifier = "SensorsListCell"

    // MARK: - Interface Properties

    let sensorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "temperatureSensorIcon")
        return image
    }()

    let sensorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Датчик 1"
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(sensorImage)

        sensorImage.centerY(inView: contentView)
        sensorImage.anchor(left: leftAnchor, paddingLeft: 16)
        sensorImage.setDimensions(width: 45, height: 45)

        contentView.addSubview(sensorNameLabel)
        sensorNameLabel.anchor(top: topAnchor, left: sensorImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 22, paddingLeft: 16, paddingBottom: 22, paddingRight: 50)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method

    public func setup(with model: TemperatureSensorsListBackendModel) {
        sensorNameLabel.text = model.title
        accessoryType = .disclosureIndicator
    }

}
