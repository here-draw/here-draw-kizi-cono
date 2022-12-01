//
//  NicknameResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/13.
//

import Foundation

struct OnboardingNicknameResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String?
}
