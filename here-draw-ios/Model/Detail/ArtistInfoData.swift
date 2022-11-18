//
//  ArtistInfoData.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import UIKit

struct ArtistInfoData {
    let nickname: String
    let profileImg: String?
    let description: String?
    var followerCnt: Int
    var isFollowing: Bool   // 본인이어도 false
    let likeCnt: Int
    let myArt: Bool
}
