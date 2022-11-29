//
//  NicknameResponse.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import Foundation
import Alamofire

// MARK: - NicknameResponse
struct NicknameResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

// MARK: - Result
struct Result: Decodable {
    let profileImage: String?
    let nickname: String
    let description: String?
}
