//
//  RegisterCell.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import UIKit
import SnapKit
import Then


class RegisterCell: UICollectionViewCell {
    
    static let identifier = "registerCell"
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "네모.png")
    }
    
    //작품의 이름이 들어올 자리
    var label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "새 작품 등록하기"
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
        self.addSubview(label)
        img.contentMode = .scaleAspectFit
        img.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(img.snp.leading)
            $0.bottom.trailing.equalTo(0)
            $0.top.equalTo(img.snp.bottom).offset(13)
           
        }
        
    }
    
    func fetchImage(image: UIImage) {
        img.image = image
    }
    
    func fetchText(text: String) {
        label.text = text
    }
}
