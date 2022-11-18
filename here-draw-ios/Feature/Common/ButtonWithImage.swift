//
//  ButtonWithImage.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import UIKit

class ButtonWithImageOnTheRight: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: (bounds.width - 110), bottom: 0, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}
