//
//  OnboardingViewModel.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/12.
//

import UIKit

class OnboardingViewModel {
    // TODO: 닉네임 중복 검사
    func doubleCheckNickname(nickname: String, onCompletion: @escaping (Bool, String) -> Void) {
        UserAPI.checkNickname(nickname: nickname) { response in
            if let result = response.result {
                onCompletion(true, result)
            }
            else {
                onCompletion(false, response.message)
            }
        }
    }
    
    // TODO: 닉네임 설정
    func setNickname(nickname: String, onCompletion: @escaping (Bool, String) -> Void) {
        UserAPI.registerNickname(parameters: NicknameRequest(nickname: nickname)) { response in
            if let result = response.result {
                UserDefaults.standard.set(nickname, forKey: "nickname")
                onCompletion(true, result)
            }
            else {
                onCompletion(false, response.message)
            }
        }
    }
    
}
