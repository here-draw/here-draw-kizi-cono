//
//  RecommendedArtsTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/18.
//

import UIKit

class RecommendedArtsTableViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    var artList: [RecommendedArtsResult]?
    
    private var titleLabel: UILabel!
    private weak var artCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with data: RecommendedArtsData?) {
        guard let data = data else { return }
        artList = data.artList
        
        contentView.backgroundColor = .mediumBlack
        
        titleLabel = UILabel().then {
            $0.text = "이런 작품들도 좋아하실 것 같아요!"
            $0.textColor = .white
            $0.font = .sfPro16Pt4
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(30)
                $0.leading.equalToSuperview().inset(26)
            }
        }
        
        artCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
            $0.delegate = nil
            $0.dataSource = self
            $0.register(ArtsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            $0.showsHorizontalScrollIndicator = false
            $0.isScrollEnabled = true
            $0.backgroundColor = .clear
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: 150, height: 150)
            flowLayout.minimumLineSpacing = 15
            flowLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
            $0.collectionViewLayout = flowLayout
            
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(15)
                $0.leading.equalToSuperview().inset(26)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(150)
            }
        }
    }
}

extension RecommendedArtsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArtsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.updateUI(image: artList![indexPath.item].artImage)
        return cell
    }
}

extension RecommendedArtsTableViewCell: UICollectionViewDelegate {
    
}
