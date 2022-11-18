//
//  ArtHashtagTableViewCell.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

import SnapKit
import Then

class ArtHashtagTableViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var hashtags: [String] = ["#캐릭터", "#귀여운", "#다이어리 꾸미기", "#굿노트 스티커", "#하이틴", "#여기그림"]
    let colors: [UIColor] = [.lavenderPink, .warmBlue, .butterscotch, .grapefruit, .pastelOrange, .blush, .palePeach, .pastelYellow, .pastelPurple]
    private var flag = [Bool](repeating: false, count: 9)    // 사용 여부
    
    
    private var titleLabel: UILabel!
    private weak var tagCollectionView: UICollectionView!

    // MARK: - Function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with data: ArtHashtagData?) {
        guard let data = data else  { return }
        
        hashtags = data.hashtags
        
        contentView.backgroundColor = .mediumBlack
        
        titleLabel = UILabel().then {
            $0.text = "작품 해시태그"
            $0.textColor = .white
            $0.font = .sfPro16Pt4
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(24)
                $0.leading.equalToSuperview().inset(20)
            }
        }
        
        tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createTagLayout()).then {
            $0.dataSource = self
            $0.delegate = self
            $0.register(ArtHashtagCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            
            contentView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(14)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview().inset(30)
            }
        }
    }
    
    private func createTagLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(60),
            heightDimension: .absolute(26)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(26)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        return layout
    }
    
    private func randomColor() -> UIColor {
        while true {
            let index = Int.random(in: 0..<colors.count)
            if !flag[index] {
                flag[index] = true
                return colors[Int.random(in: 0..<colors.count)]
            }
        }
    }
}

// MARK: - extensions

extension ArtHashtagTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashtags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ArtHashtagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let hashtag = hashtags[indexPath.item]
        let color = randomColor()
        cell.updateUI(hashtag: hashtag, color: color)
        
        return cell
    }
}

extension ArtHashtagTableViewCell: UICollectionViewDelegate {
    
}
