//
//  PersonalCabinetInterface.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 03.02.2022.
//

import UIKit

final class PersonalCabinetUtilities: UIView {

    // MARK: - Public Methods

    public func createCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemGray6
        cell.selectionStyle = .none
        return cell
    }

    public func createTextField(placeholder: String, text: String = "") -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.text = text
        tf.isUserInteractionEnabled = false
        return tf
    }

    public func createView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }

}
