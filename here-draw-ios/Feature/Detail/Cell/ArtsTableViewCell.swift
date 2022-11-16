//
//  ArtsTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

class ArtsTableViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(artType: Int) {
        switch artType {
        case 0:
            contentView.backgroundColor = .green
        case 1:
            contentView.backgroundColor = .blue
        default:
            return
        }
    }

}
