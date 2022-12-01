//
//  DetailTableViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/16.
//

import UIKit

extension DetailTableViewController {
    enum DetailTableviewType: Int, CaseIterable {
        case artInfo
        case artHashtag
        case artistInfo
        case otherArts
        case recommendedArts
        
        var cellType: UICollectionViewCell.Type {
            switch self {
            case .artInfo: return ArtInfoTableViewCell.self
            case .artHashtag: return ArtHashtagTableViewCell.self
            case .artistInfo: return ArtistInfoTableViewCell.self
            case .otherArts: return OtherArtsTableViewCell.self
            case .recommendedArts: return RecommendedArtsTableViewCell.self
            }
        }
        
        var cellIdentifier: String {
            switch self {
            case .artInfo: return "artInfo"
            case .artHashtag: return "artHashtag"
            case .artistInfo: return "artistInfo"
            case .otherArts: return "otherArts"
            case .recommendedArts: return "recommendedArts"
            }
        }
        
        var height: CGFloat {
            switch self {
            case .artInfo: return 400   // 펼쳤을 때, 534
            case .artHashtag: return 151
            case .artistInfo: return 253
            case .otherArts: return 245
            case .recommendedArts: return 245
            }
        }
    }
}

class DetailTableViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var currentRow = 0 {
        didSet {
            updateTabButton()
            autoScroll()
        }
    }
    
    var detailArtInfoData: DetailArtInfoData?
    var artHashtagData: ArtHashtagData?
    var artistInfoData: ArtistInfoData?
    var otherArtsData: ArtsData?
    var recommendedArtsData: RecommendedArtsData?
    
    var fetchDone: Bool = false {
        didSet {
            if fetchDone {
                artDetailTableView.reloadData()
            }
        }
    }
    
    // 헤더뷰
    /// ㄴ 탭 스택뷰
    ///  ㄴ 작품 정보 탭 버튼
    ///  ㄴ 작가님 정보 탭 버튼
    /// ㄴ bar의 백그라운드 line 뷰
    /// ㄴ 현재 정보 bar 뷰
    public weak var headerView: UIView!
    private weak var tabStackView: UIStackView!
    private weak var artTabButton: UIButton!
    private weak var artistTabButton: UIButton!
    private weak var barBackgroundView: UIView!
    private weak var barView: UIView!
    
    // 정보 담을 테이블 뷰
    /// ㄴ 디테일 작품 정보
    /// ㄴ 작품 해시태그
    /// ㄴ 작가 정보
    /// ㄴ 다른 작품
    /// ㄴ 추천작품
    private weak var artDetailTableView: UICollectionView!

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    private func updateTabButton() {
        barView.snp.updateConstraints {
            let sectionIndex = currentRow == 0 ? 0: 1
            $0.leading.equalToSuperview().inset(CGFloat(sectionIndex) * barView.frame.width)
        }
    }
    
    private func autoScroll() {
        let indexPath = IndexPath(item: currentRow, section: 0)
        artDetailTableView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    override func setLayout() {
        view.backgroundColor = .mediumBlack
        
        headerView = UIView().then {
            $0.backgroundColor = .mediumBlack
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            }
        }
        
        tabStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.backgroundColor = .clear
            headerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        artTabButton = UIButton().then {
            $0.setTitle("작품정보", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .sfPro16Pt4
            $0.addTarget(self, action: #selector(selectTabButton(_:)), for: .touchUpInside)
            tabStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().dividedBy(2)
            }
        }
        
        artistTabButton = UIButton().then {
            $0.setTitle("작가님 정보", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .sfPro16Pt4
            $0.addTarget(self, action: #selector(selectTabButton(_:)), for: .touchUpInside)
            tabStackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
        
        barBackgroundView = UIView().then {
            $0.backgroundColor = .mediumGrey
            headerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }
        
        barView = UIView().then {
            $0.backgroundColor = .pastelYellow
            barBackgroundView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.equalToSuperview().dividedBy(2)
                $0.height.equalTo(2)
            }
        }
        
        artDetailTableView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
            $0.dataSource = self
            $0.delegate = self
            
            $0.backgroundColor = .greyishMediumBrown
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = true
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            $0.collectionViewLayout = layout
            
            for type in DetailTableviewType.allCases {
                $0.register(type.cellType, forCellWithReuseIdentifier: type.cellIdentifier)
            }
            
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(headerView.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    @objc
    func selectTabButton(_ sender: UIButton) {
        currentRow = sender === artTabButton ? 0: 2
    }
}

// MARK: - Extensions

extension DetailTableViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = DetailTableviewType(rawValue: indexPath.item)
        return CGSize(width: collectionView.frame.width, height: type!.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DetailTableviewType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = DetailTableviewType(rawValue: indexPath.row)
        
        switch type {
        case .artInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type?.cellIdentifier ?? "", for: indexPath) as? ArtInfoTableViewCell else {
                return UICollectionViewCell()
            }
            
            cell.updateUI(with: detailArtInfoData)
            return cell
        case .artHashtag:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type?.cellIdentifier ?? "", for: indexPath) as? ArtHashtagTableViewCell else {
                return UICollectionViewCell()
            }
            
            cell.updateUI(with: artHashtagData)
            return cell
        case .artistInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type?.cellIdentifier ?? "", for: indexPath) as? ArtistInfoTableViewCell else { return UICollectionViewCell() }
            
            cell.updateUI(with: artistInfoData)
            return cell
        case .otherArts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type?.cellIdentifier ?? "", for: indexPath) as? OtherArtsTableViewCell else { return UICollectionViewCell() }
            
            cell.updateUI(with: otherArtsData)
            return cell
        case .recommendedArts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type?.cellIdentifier ?? "", for: indexPath) as? RecommendedArtsTableViewCell else { return UICollectionViewCell() }
            
            cell.updateUI(with: recommendedArtsData)
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}

extension DetailTableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = DetailTableviewType(rawValue: indexPath.row) else { return }
        switch type {
        case .artInfo:
            break
        case .artHashtag:
            break
        case .artistInfo:
            // TODO: 작가 홈 연결
            break
        case .otherArts:
            break
        case .recommendedArts:
            break
        }
    }
}
