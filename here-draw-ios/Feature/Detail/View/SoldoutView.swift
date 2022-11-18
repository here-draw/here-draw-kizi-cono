//
//  SoldoutView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import UIKit

import SnapKit
import Then

class SoldoutView: BaseView {
    
    override func setLayout() {
        
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(visualEffectView)
        
        let circle = UIView().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 50
            $0.layer.borderColor = UIColor.pastelYellow.cgColor
            $0.layer.borderWidth = 2
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 100, height: 100))
                $0.center.equalToSuperview()
            }
        }
        
        let textLabel = UILabel().then {
            $0.text = "판매\n완료"
            $0.font = .sfPro22Pt
            $0.textColor = .pastelYellow
            $0.textAlignment = .center
            $0.numberOfLines = 2
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }

}
