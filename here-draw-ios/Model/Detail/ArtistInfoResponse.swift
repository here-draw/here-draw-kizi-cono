//
//  ArtistInfoResponse.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/17.
//

import Foundation

struct ArtistInfoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ArtistInfoResult?
}

// MARK: - Result
struct ArtistInfoResult: Decodable {
    let profileImg: String?
    let nickname: String
    let description: String?
    let followerCnt, likeCnt: Int
    let isFollowing, hasArticle: Bool
}
