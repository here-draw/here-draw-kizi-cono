//
//  UIView+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import UIKit

extension UIView {
    func shadow(opacity: Float, color: UIColor, offset: CGSize) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
    }
}
