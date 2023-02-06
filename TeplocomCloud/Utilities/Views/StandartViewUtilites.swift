//
//  Utilites.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 25.01.2022.
//

import UIKit

final class StandartViewUtilites {

    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()

        // image
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = image

        view.addSubview(iv)
        iv.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)

        // textField
        view.addSubview(textField)
        textField.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)

        // линия подчеркивания - dividerView
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)

        return view
    }

    func textField(withPlaceholder placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }
}
