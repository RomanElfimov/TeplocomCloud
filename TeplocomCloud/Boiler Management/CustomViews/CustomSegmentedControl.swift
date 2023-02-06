//
//  CustomSegmentedControl.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 02.05.2022.
//

import UIKit

// MARK: - CustomSegmentedControl Delegate

protocol CustomSegmentedControlDelegate: AnyObject {
    func change(to index: Int)
}

final class CustomSegmentedControl: UIView {

    // MARK: - Public Properties

    weak var segmentedControlDelegate: CustomSegmentedControlDelegate?
    private(set) var selectedIndex: Int = 0

    // MARK: - Private Properties

    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!

    private var textColor: UIColor = .black
    var selectorViewColor: UIColor = UIColor(named: "TeplocomColor")!
    var selectorTextColor: UIColor = UIColor(named: "TeplocomColor")!

    // MARK: - Inits

    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }

    // MARK: - Private Method

    private func setIndex(index: Int) {
        buttons.forEach {( $0.setTitleColor(textColor, for: .normal)) }
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }

    // MARK: - Selector

    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                segmentedControlDelegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }

}

// MARK: - UI Setup Extension

extension CustomSegmentedControl {

    private func updateView() {
        createButton()
        configureSelectorView()
        createStackView()
    }

    private func createStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }

    private func configureSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: self.frame.height,
                                            width: selectorWidth,
                                            height: 2))

        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }

    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
}
