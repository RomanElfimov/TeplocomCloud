//
//  UIViewController + Extension.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 18.08.2021.
//

import UIKit

// MARK: - Alert

extension UIViewController {
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
