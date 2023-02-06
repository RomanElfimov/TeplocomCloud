//
//  BindedDevicesTableViewCell.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.02.2022.
//

import UIKit

final class BindedDevicesTableViewCell: UITableViewCell {

    // MARK: - Reuse ID

    static let cellIdentifier = "BindedDevicesCell"

    // MARK: - Interface Properties

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = UIColor(named: "TeplocomColor")
        return label
    }()

    let uidLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .right
        label.textColor = UIColor(named: "TeplocomColor")
        return label
    }()

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(statusLabel)
        statusLabel.centerY(inView: contentView)
        statusLabel.anchor(right: rightAnchor, paddingRight: 16)

        let stack = UIStackView(arrangedSubviews: [nameLabel, uidLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillProportionally
        contentView.addSubview(stack)

        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: statusLabel.leftAnchor, paddingTop: 22, paddingLeft: 16, paddingBottom: 22, paddingRight: 16)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method

    public func setup(with model: BindedDevicesViewModel) {
        nameLabel.text = model.name
        uidLabel.text = model.uid
        statusLabel.text = model.status ? "В сети" : "Не в сети"
    }

}
