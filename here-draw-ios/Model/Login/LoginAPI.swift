//
//  LoginAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/11.
//

import Foundation
import Alamofire

class LoginAPI {
    // 자동 로그인
    static func autoLogin(sceneDelegate: SceneDelegate) {
        let url = NetworkUtils.baseURL + "/users/login"
        let jwt = NetworkUtils.jwt
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : jwt ?? ""]
        
        AF.request(url, method: .patch, headers: headers)
            .validate().responseDecodable(of: AutoLoginResponse.self) { response in
                switch response.result {
                case .success(let data):
                    switch data.isSuccess {
                    case true:
                        print(data.result!)
                        
                        if UserDefaults.standard.string(forKey: "nickname") != nil {
                            sceneDelegate.goToMain()
                        } else {
                            // go Onboarding
                        }
                        
                    case false:
                        print("자동로그인 실패: \(data.message)")
                        switch data.code {
                        // jwt 없음
                        case 2001:
                            sceneDelegate.goToLogin()
                        // 유효하지 않은 jwt
                        case 2002:
                            sceneDelegate.goToLogin()
                        // 로그인 불가 유저
                        case 2007:
                            print(data.message)
                            sceneDelegate.goToLogin()
                        default:
                            print(data.message)
                            sceneDelegate.goToLogin()
                        }
                    }
                    
                case .failure(let error):
                    print("에러 response: \(response)")
                    print("에러 발생: \(error)")
                    sceneDelegate.goToLogin()
                }
            }
    }
    
    // 카카오 소셜로그인
    static func loginKakao(parameters: LoginRequest, onCompletion: @escaping (SocialLoginResponse) -> Void) {
        let url = NetworkUtils.baseURL + "/users/kakao"

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate().responseDecodable(of: SocialLoginResponse.self) { response in
                switch response.result {
                case .success(let data):
                    switch data.isSuccess {
                    case true:
                        onCompletion(data)
                    case false:
                        print("실패: \(data.message)")
                    }

                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
    
    // 애플 소셜로그인
    static func loginApple(parameters: LoginRequest, onCompletion: @escaping (SocialLoginResponse) -> Void) {
        let url = NetworkUtils.baseURL + "/users/apple"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate().responseDecodable(of: SocialLoginResponse.self) { response in
                switch response.result {
                case .success(let data):
                    switch data.isSuccess {
                    case true:
                        onCompletion(data)
                    case false:
                        print("실패: \(data.message)")
                    }
                    
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
}
