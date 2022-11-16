//
//  OtherArtsResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation

struct OtherArtsResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: OtherArtsResult?
}

struct OtherArtsResult: Decodable {
    let count: Int
    let artList: [ArtList]
}

// MARK: - ArtList
struct ArtList: Decodable {
    let artId, artistId: Int
    let artImage: String
    let title: String
    let price: Int
    let like, sales: Bool
}
