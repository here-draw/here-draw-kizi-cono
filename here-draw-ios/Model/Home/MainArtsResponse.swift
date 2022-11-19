//
//  MainArtsResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/19.
//

import Foundation

struct MainArtsResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MainArtsResult?
}

struct MainArtsResult: Decodable {
    var hasNextScroll: Bool
    var artIdCursor: Int
    var dateCursor: String
    var artInfoList: [ArtInfoList]
}

struct ArtInfoList: Codable {
    let artId, artistId: Int
    let artImage: String
    let width, height: Int
    let title: String
}
