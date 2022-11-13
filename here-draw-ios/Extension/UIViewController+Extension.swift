//
//  UIViewController+Extension.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/12.
//

import UIKit

import Then
import SnapKit

extension UIViewController {
    // 화면 터치 시 키보드 내려가도록
    func dismissKeyboardByTouching() {
        let tap: UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // UIWindow의 rootViewController 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        let vc = UINavigationController(rootViewController: viewControllerToPresent)
        if let window = self.view.window {
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    func showToast(message: String) {
        // frame: CGRect(x: 47, y: view.frame.size.height - 400, width: view.frame.size.width - 94, height: 97)
        let toastView = UIView().then {
            $0.backgroundColor = .greyishDeepBrown
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            view.addSubview($0)
        }
        
        let toastLabel = UILabel().then {
            $0.text = message
            $0.textAlignment = .center
            $0.textColor = .white
            $0.font = .sfPro14Pt
            $0.clipsToBounds = true
            $0.numberOfLines = 2
            $0.sizeToFit()
            toastView.addSubview($0)
        }
        
        toastView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(47)
            $0.height.equalTo(toastLabel.snp.height).offset(60)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        // 토스트 애니메이션
        UIView.animate(
            withDuration: 3.0, delay: 0.1,
            options: .curveEaseIn, animations: { toastView.alpha = 0.0 },
            completion: {_ in toastView.removeFromSuperview() }
        )
    }
}
