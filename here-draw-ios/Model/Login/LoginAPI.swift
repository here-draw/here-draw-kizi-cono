//
//  LoginAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/11.
//

import Foundation
import Alamofire

class LoginAPI {
    // 카카오 소셜로그인
    static func loginKakao(parameters: LoginRequest, onCompletion: @escaping (LoginResponse) -> Void) {
        let url = NetworkUtils.baseURL + "/users/kakao"

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate().responseDecodable(of: LoginResponse.self) { response in
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
    static func loginApple(parameters: LoginRequest, onCompletion: @escaping (LoginResponse) -> Void) {
        let url = NetworkUtils.baseURL + "/users/apple"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate().responseDecodable(of: LoginResponse.self) { response in
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
