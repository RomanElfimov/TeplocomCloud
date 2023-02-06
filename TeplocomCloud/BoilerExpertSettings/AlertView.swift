//
//  AlertView.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 07.07.2022.
//

import UIKit

final class ConnectionAlertView: UIView {

    // MARK: - Interface Properties

    private lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let alertView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

    private lazy var firstDescriptionLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init

    init(frame: CGRect, title: String?, description: String?) {
        super.init(frame: frame)
        setupView()

        firstDescriptionLabel.text = title
        secondDescriptionLabel.text = description

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.4) {
                self.alpha = 0
                self.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            } completion: { _ in
                self.removeFromSuperview()
                self.isUserInteractionEnabled = true
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Setup Interface Private Method

    private func setupView() {

        // blur view
        addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        // alert view
        visualEffectView.contentView.addSubview(alertView)
        alertView.backgroundColor = .systemBackground
        alertView.layer.cornerRadius = 20

        alertView.center(inView: visualEffectView)
        alertView.setDimensions(width: 250, height: 100)

        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0

        UIView.animate(withDuration: 0.4) {
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }

        // description labels
        let stack = UIStackView(arrangedSubviews: [firstDescriptionLabel, secondDescriptionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4

        alertView.addSubview(stack)

        stack.anchor(top: alertView.topAnchor, left: alertView.leftAnchor, bottom: alertView.bottomAnchor, right: alertView.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 18)
    }
}
