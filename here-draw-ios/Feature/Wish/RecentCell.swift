//
//  RecentCell.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/18.
//

import UIKit

class RecentCell: UICollectionViewCell {
    static let identifier = "recentCell"
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "네모.png")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //주륵....
    func cellSetting() {
        self.backgroundColor = .gray
        self.addSubview(img)
        img.contentMode = .scaleAspectFit
        
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        
        img.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func fetchImage(image: UIImage) {
        img.image = image
    }
}
