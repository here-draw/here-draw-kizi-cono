//
//  ArtInfoTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

class ArtInfoTableViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        contentView.backgroundColor = .red
    }

}
