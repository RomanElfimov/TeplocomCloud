//
//  ThumbTemperatureSlider.swift
//  TeplocomCloud
//
//  Created by Роман Елфимов on 03.05.2022.
//

import UIKit

final class ThumbTemperatureSlider: UISlider {

    // MARK: - Public Properties

    public var minValue: Float = 0
    public var maxValue: Float = 100
    public var trackColor =  UIColor(named: "TeplocomColor")

    // MARK: - Private Properties

    private var thumbTextLabel: UILabel = UILabel()

    private var thumbFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }

    // MARK: - LifeCycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        thumbTextLabel.frame = thumbFrame
        thumbTextLabel.text = Int(value.rounded()).description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // MARK: - Configure Method

    private func configure() {
        minimumValue = minValue
        maximumValue = maxValue
        value = maxValue / 2
        minimumTrackTintColor = trackColor

        addSubview(thumbTextLabel)

        thumbTextLabel.font = UIFont.systemFont(ofSize: 14)
        thumbTextLabel.minimumScaleFactor = 0.5
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
    }
}
