//
//  ArtInfoResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import Foundation

struct ArtInfoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ArtInfoResult?
}

// MARK: - Result
struct ArtInfoResult: Decodable {
    let artistId: Int
    let artImage: String
    let width, height: Int
    let title: String
    let price: Int
    let exclusive: Bool
    let additionalCharge: Int
    let simpleDescription, description: String
    let like: Int
    let filetype, copyright, tag: [String]
    let sales, myArt: Bool
}
