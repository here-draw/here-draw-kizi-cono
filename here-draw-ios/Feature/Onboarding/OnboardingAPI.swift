//
//  OnboardingAPI.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/13.
//

import Foundation
import Alamofire

class OnboardingAPI {
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
    
    // 닉네임 설정
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
}
