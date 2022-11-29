//
//  PurchasedItems.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import UIKit

class PurchasedItems: UIViewController {
    
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
        
        collectionView.register(PurchasedCell.self, forCellWithReuseIdentifier: PurchasedCell.identifier)
        
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



extension PurchasedItems : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchasedCell.identifier, for: indexPath) as? PurchasedCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .none
        cell.fetchImage(image: images[0])
        cell.fetchText(text: names[0])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        let itemInset: CGFloat = 20
        
        let myWidth : CGFloat = (collectionView.bounds.width - itemInset * 0.7 - itemSpacing)/2
        let myHeight = myWidth + getLabelHeight() + 13
        
        
        return CGSize(width: myWidth, height: myHeight)
    }
}
