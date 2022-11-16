//
//  RecommendedArtsResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation

struct RecommendedArtsResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RecommendedArtsResult]? // 호출 성공했지만 추천 작품 없을 때는 빈 리스트
}

struct RecommendedArtsResult: Codable {
    let artId, artistId: Int
    let artImage: String
    let like: Bool
}
