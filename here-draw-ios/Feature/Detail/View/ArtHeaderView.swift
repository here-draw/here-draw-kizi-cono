//
//  ArtHeaderView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/14.
//

import UIKit

class ArtHeaderView: BaseView {
    // 간단 작품 정보 뷰
    private weak var artSimpleInfoView: UIView!
    private weak var artThumbnailImageView: UIImageView!
    private weak var artistProfileInArtInfoImageView: UIImageView!
    private weak var artistNicknameInArtInfoLabel: UILabel!
    private weak var goArtistHomeInArtInfoButton: UIButton!
    private weak var artNameInArtInfoLabel: UILabel!
    private weak var artPriceInArtInfoLabel: UILabel!
    private weak var artSimpleDescriptionInArtInfoLabel: UILabel!
    private weak var artFileTypeStackView: UIStackView! // file type uiview를 넣을 스택뷰
    
    private weak var watermarkLabel: UILabel!

}
