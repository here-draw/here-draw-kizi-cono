//
//  UIImageView+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: String) {
        let URL = URL(string: url)
        self.kf.setImage(with: URL)
    }
}
