//
//  ArtHashtagCollectionViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import UIKit

import SnapKit
import Then

class ArtHashtagCollectionViewCell: UICollectionViewCell {
    private weak var tagButton: UIButton!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    public func updateUI(hashtag: String, color: UIColor) {
        tagButton = UIButton().then {
            $0.backgroundColor = color
            $0.setTitle(hashtag, for: .normal)
            $0.setTitleColor(.greyishDeepBrown, for: .normal)
            $0.titleLabel?.font = .sfPro11Pt
            $0.titleLabel?.sizeToFit()
            $0.layer.cornerRadius = 13
            contentView.addSubview($0)
        }
        
        tagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(tagButton.titleLabelWidth() + 12)
        }
    }
    
    
}
