//
//  ArtsCollectionViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

import SnapKit
import Then

class ArtsCollectionViewCell: UICollectionViewCell {
    private weak var artImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(image: String) {
        artImageView = UIImageView().then {
            $0.loadImage(url: image)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
