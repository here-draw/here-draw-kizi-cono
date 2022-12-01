//
//  SplashViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import UIKit

import SnapKit
import Then

class SplashViewController: BaseViewController {
    
    let delay: Double = 3.0

    override func viewDidLoad() {
        super.viewDidLoad()
        timer()
    }
    
    func timer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UserAPI.autoLogin(viewController: self)
//            self.goToMain()
        }
    }
    
    override func setLayout() {
        let splashView = UIView().then {
            view.addSubview($0)
        }
        
        let titleLabel = UILabel().then {
            $0.text = "여기그림"
            $0.textColor = .pastelYellow
            $0.font = .gmarketSans40Pt
            $0.sizeToFit()
            splashView.addSubview($0)
        }
        
        let subTitleLabel = UILabel().then {
            $0.text = "세상 모든 일러스트"
            $0.textColor = .lightGrey
            $0.font = .gmarketSans18Pt
            $0.sizeToFit()
            splashView.addSubview($0)
        }
        
        splashView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(titleLabel.frame.width)
            $0.height.equalTo(titleLabel.frame.height + subTitleLabel.frame.height + 18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}
