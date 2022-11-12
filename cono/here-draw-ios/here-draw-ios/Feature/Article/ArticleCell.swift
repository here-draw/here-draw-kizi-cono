//
//  ArticleCell.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/12.
//

import UIKit
import SwiftUI

class ArticleCell: UICollectionViewCell {
    
    static let identifier = "articleCell"
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "네모.png")
    }

    var label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "제목"
    }
    var label2 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "작가 이름"
    }
    var label3 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "본문 90자까지"
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
        self.backgroundColor = .black1
        self.addSubview(img)
        self.addSubview(label)
        self.addSubview(label2)
        self.addSubview(label3)
        
        img.contentMode = .left
        img.contentMode = .scaleAspectFit
        img.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
    
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(img.snp.trailing).offset(17)
        }
        label2.snp.makeConstraints {
            $0.leading.equalTo(img.snp.trailing).offset(17)
            $0.top.equalTo(label.snp.bottom).offset(5)
        }
        label3.snp.makeConstraints {
            $0.leading.equalTo(img.snp.trailing).offset(17)
            $0.top.equalTo(label2.snp.bottom).offset(5)
            
            $0.trailing.equalToSuperview()
        }
        label3.font = .sfPro11Pt
        label3.numberOfLines = 4
        
    }
    
    func fetchImage(image: UIImage) {
        img.image = image
    }
    
    func fetchText(text: String) {
        label.text = text
    }
    func fetchText2(text: String) {
        label2.text = text
    }
    func fetchText3(text: String) {
        label3.text = text
    }
}
