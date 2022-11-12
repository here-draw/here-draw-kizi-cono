//
//  MyItems.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import UIKit
import SwiftUI
import SnapKit

class MyItems: UIViewController {
    
    var images: [UIImage] = [
        UIImage(named: "cat")!,
        UIImage(named: "dog")!
    ]
    
    var names: [String] = [
        "고양이는 야옹야옹",
        "강아지는 왈왈오랑로아러"
    ]
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 53
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    func collectionViewsetup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20))
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RegisterCell.self, forCellWithReuseIdentifier: RegisterCell.identifier)
        collectionView.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.identifier)
        
    }
    
    func getLabelHeight() -> CGFloat {
        let label = UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "새 작품 등록하기"
            $0.sizeToFit()
        }
        return label.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewsetup()
    }
    
    
    
    
}



extension MyItems : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.identifier, for: indexPath) as? ItemsCell else {
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = .none
            cell.img.image = UIImage(named: "네모.png")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterCell.identifier, for: indexPath) as? RegisterCell else {
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = .none
            cell.fetchImage(image: images[indexPath.item - 1])
            cell.fetchText(text: names[indexPath.item - 1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        let itemInset: CGFloat = 20
        
        let myWidth : CGFloat = (collectionView.bounds.width - itemInset * 0.7 - itemSpacing)/2
        let myHeight = myWidth + getLabelHeight() + 13
        
        
        return CGSize(width: myWidth, height: myHeight)
    }
}
