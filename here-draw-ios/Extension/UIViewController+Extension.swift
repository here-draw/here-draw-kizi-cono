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
}
