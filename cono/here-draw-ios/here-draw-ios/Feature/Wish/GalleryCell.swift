//
//  GalleryCell.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/18.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    static let identifier = "galleryCell"
    
    var img = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "네모.png")
        
    }
    
    //작품의 이름이 들어올 자리
    var label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "기본 갤러리"
        $0.font = .sfPro14Pt
    }
    
    
    

    var count_label = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "140개"
        $0.font = .sfPro11Pt
        $0.textColor = .brownGrey
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
        self.addSubview(count_label)
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(img.snp.leading)
            $0.bottom.trailing.equalTo(0)
            $0.top.equalTo(img.snp.bottom).offset(13)
        }
//        count_label.snp.makeConstraints {
//            $0.top.equalTo(label.snp.bottom).offset(13)
//            $0.leading.equalTo(img.snp.leading)
//            $0.bottom.trailing.equalTo(0)
//        }
        
    }
    
    func fetchImage(image: UIImage) {
        img.image = image
    }
    
    func fetchText(text: String) {
        label.text = text
    }
    func fetchText2(text: String) {
        count_label.text = text
    }
}
