//
//  UserAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation
import Alamofire

class UserAPI {
    // 자동 로그인
    static func autoLogin(viewController: BaseViewController) {
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
                            viewController.goToMain()
                        } else {
                            // go Onboarding
                            viewController.changeRootViewController(OnboardingViewController())
                        }
                        
                    case false:
                        print("자동로그인 실패: \(data.message)")
                        switch data.code {
                        // jwt 없음
                        case 2001:
                            viewController.changeRootViewController(LoginViewController())
                        // 유효하지 않은 jwt
                        case 2002:
                            viewController.changeRootViewController(LoginViewController())
                        // 로그인 불가 유저
                        case 2007:
                            print(data.message)
                            viewController.changeRootViewController(LoginViewController())
                        default:
                            print(data.message)
                            viewController.changeRootViewController(LoginViewController())
                        }
                    }
                    
                case .failure(let error):
                    print("에러 response: \(response)")
                    print("에러 발생: \(error)")
                    viewController.changeRootViewController(LoginViewController())
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
    
    // 닉네임 중복 체크
    static func checkNickname(nickname: String, onCompletion: @escaping (NicknameResponse) -> Void) {
        let url = NetworkUtils.baseURL + "/users/check" + "?nickname=\(nickname)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(url, method: .get)
            .validate().responseDecodable(of: NicknameResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = data.message
                    if data.isSuccess {
                        print(message)
                        onCompletion(data)
                    } else {
                        print("실패: \(message)")
                        onCompletion(data)
                    }
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
    
    // 초기 닉네임 설정
    static func registerNickname(parameters: NicknameRequest, onCompletion: @escaping (NicknameResponse) -> Void) {
        let url = NetworkUtils.baseURL + "/users/nickname"
        let jwt = NetworkUtils.jwt
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : jwt ?? ""]
        
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate().responseDecodable(of: NicknameResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = data.message
                    if data.isSuccess {
                        print(message)
                        onCompletion(data)
                    } else {
                        print("실패: \(message)")
                        onCompletion(data)
                    }
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
    
    // 작가 정보 조회
    static func artistInfo(artistId: Int, onCompletion: @escaping (ArtistInfoResult) -> Void) {
        let url = NetworkUtils.baseURL + "/users" + "/\(artistId)" + "/artist-info"
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": NetworkUtils.jwt!]
        
        print(url)
        AF.request(url, method: .get, headers: headers)
            .validate().responseDecodable(of: ArtistInfoResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let message = data.message
                    if data.isSuccess {
                        print(message)
                        onCompletion(data.result!)
                    } else {
                        print("실패: \(message)")
                    }
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }
    }
}
