//
//  MenuTableViewCell.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 29.01.2022.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {

    // MARK: - Reuse ID

    static let reuseId = "Cell"

    // MARK: - Interface Properties

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kastom"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "TeplocomColor2")
        return label
    }()

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(iconImageView)
        contentView.addSubview(myLabel)

        backgroundColor = .clear

        // iconImageView constraints
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true

        // myLabel constraints
        myLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
