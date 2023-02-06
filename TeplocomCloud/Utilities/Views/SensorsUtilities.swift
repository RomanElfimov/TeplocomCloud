//
//  SensorsSettingsUtilities.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 01.04.2022.
//

import UIKit

final class SensorsUtilities: UIView {

    // MARK: - Public Methods

    public func createCell(isDisclosure: Bool = false) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .systemGray6
        cell.selectionStyle = .none
        cell.accessoryType = isDisclosure ? .disclosureIndicator : .none
        return cell
    }

    public func createTextField(placeholder: String, text: String = "") -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.text = text
        tf.isUserInteractionEnabled = true
        return tf
    }
}
