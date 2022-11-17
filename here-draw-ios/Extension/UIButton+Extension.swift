//
//  UIButton+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/21.
//

import UIKit

extension UIButton {
    
    func removeShadow() {
        self.layer.shadowOpacity = 0
    }
    
    func alignTextBelow(_ spacing: CGFloat = 0) {
        guard let image = self.imageView?.image else { return }
        
        guard let titleLabel = self.titleLabel else { return }
        
        guard let titleText = titleLabel.text else { return }
        
        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font : titleLabel.font as Any
        ])
        
        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}
