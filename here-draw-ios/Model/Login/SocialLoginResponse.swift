//
//  SocialLoginResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/11.
//

import Foundation

struct SocialLoginResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LoginResult?
}

struct LoginResult: Decodable {
    let jwt: String
    let nickname: String?
}
