//
//  LoginViewModel.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/12.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth

import Alamofire

class LoginViewModel {
    
    func handleKakaoLogin(onCompletion: @escaping (Bool) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("kakao sdk api error: \(error)")
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    guard let token = oauthToken?.accessToken else { return }
                    print("kakao accessToken: \(token)")
                    
                    LoginAPI.loginKakao(parameters: LoginRequest(accessToken: token)) { [weak self] response in
                        print(response)
                        
                        UserDefaults.standard.set(response.result?.jwt, forKey: "jwt")
                        
                        if let nickname = response.result?.nickname {
                            UserDefaults.standard.set(nickname, forKey: "nickname")
                            onCompletion(true)
                        } else {    // 최초 로그인 시(닉네임 X)
                            onCompletion(false)
                        }
                    }
                }
            }
        }
    }
                                        

}
