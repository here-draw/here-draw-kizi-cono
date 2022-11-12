//
//  AutoLoginResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/12.
//

import Foundation

struct AutoLoginResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String?
}
