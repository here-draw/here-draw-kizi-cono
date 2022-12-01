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
                    
                    UserAPI.loginKakao(parameters: LoginRequest(accessToken: token)) { [weak self] response in
                        print(response)
                        
                        UserDefaultUtils.saveKakaoLoginInfo(
                            response.result?.jwt,
                            response.result?.nickname
                        )
                        
                        if let nickname = response.result?.nickname {
                            onCompletion(true)
                        } else {    // 최초 로그인 시(닉네임 X)
                            onCompletion(false)
                        }
                    }
                }
            }
        }
    }
    
    func handleAppleLogin(token: String, onCompletion: @escaping (Bool) -> Void) {
        UserAPI.loginApple(parameters: LoginRequest(accessToken: token)) { [weak self] response in
            print("애플 로그인 api 연결 성공: \(response)")
            
            UserDefaultUtils.saveAppleLoginInfo(
                token,
                response.result?.jwt,
                response.result?.nickname
            )
            
            if let nickname = response.result?.nickname {
                onCompletion(true)
            } else {    // 최초 로그인 시(닉네임 X)
                onCompletion(false)
            }
        }
    }
}
