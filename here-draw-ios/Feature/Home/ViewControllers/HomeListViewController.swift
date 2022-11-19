//
//  HomeListViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/19.
//

import UIKit

class HomeListViewController: BaseViewController, PageComponentProtocol {
    
    // MARK: - Properties
    
    var pageTitle: String
//    let artModels = HomeArtModel.dummy
    var artInfoList: [ArtInfoList]?
    var reloadFlag = true
    var isLoading = false
    
    fileprivate var artCollectionView: UICollectionView!
    private var loadingView: LoadingCollectionReusableView?

    // MARK: - View Life Cycle
    
    let viewModel = HomeListViewModel()
    
    init(type: String) {
        self.pageTitle = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMainArts(type: .firstLoad(pageTitle)) { availableReload in
            self.artInfoList = self.viewModel.artInfoList()
            self.reloadFlag = availableReload
            self.updateUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setCollectionViewHeight()
//        artCollectionView.reloadData()
        artCollectionView.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - Functions
    
    func updateUI() {
        artCollectionView.reloadData()
    }
    
    private func loadMoreData() {
        if !isLoading {
            isLoading.toggle()
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                // Download more data here
                DispatchQueue.global().async {
                    let cursor = self.viewModel.cursor()
                    self.viewModel.fetchMainArts(type: .reload(self.pageTitle, cursor.0, cursor.1)) { availableReload in
                        self.artInfoList = self.viewModel.artInfoList()                        
                        self.reloadFlag = availableReload
                        self.isLoading = false
                        self.isLoading.toggle()
                        DispatchQueue.main.async {
                            self.updateUI()
                        }
                    }
                }
            }
        }
    }
    
    func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {
        // fake label
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude)).then {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = .sfPro11Pt2
            $0.text = text
            $0.sizeToFit()
        }
        return label.frame.height
    }
    
//    func setCollectionViewHeight() {
//        artCollectionView.snp.makeConstraints {
//            $0.height.equalTo(artCollectionView.collectionViewLayout.collectionViewContentSize.height)
//        }
//    }
    
    override func setLayout() {
        self.view.backgroundColor = .systemBackground
        
        let layout = PinterestLayout().then {
            $0.delegate = self
        }
        
        artCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.dataSource = self
            $0.register(HomeArtCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            $0.register(
                LoadingCollectionReusableView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: "loadingView"
            )
            $0.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            $0.backgroundColor = .black1
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            self.view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalTo(self.view.safeAreaInsets)
            }
        }
        view.layoutIfNeeded()
    }
}

// MARK: - Extension UICollectionViewDataSource

extension HomeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artInfoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeArtCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        guard let artInfo = artInfoList?[indexPath.item] else { return UICollectionViewCell() }
        cell.fetchItem(model: artInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading || !reloadFlag { // 로딩중이거나 || 서버의 모든 이미지 다 불러왔다면,
            return CGSize.zero // 로딩하면 안됨.
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingView", for: indexPath) as? LoadingCollectionReusableView else { return  UICollectionReusableView() }
            loadingView = footerView
            loadingView!.setLayout()
            loadingView!.backgroundColor = .purple
            return footerView
        }
        return  UICollectionReusableView()
    }
    
    // 인디케이터 로딩 애니메이션 시작. (footer appears)
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            if isLoading {
                self.loadingView?.loadingIndicator.startAnimating()
            } else {
                self.loadingView?.loadingIndicator.stopAnimating()
            }
        }
    }
    // 인디케이터 로딩 애니메이션 끝. (footer disappears)
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loadingIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !reloadFlag { // 서버의 모든 이미지 다 불러왔다면,
            print("로딩 불가 (데이터 끝)") //  더이상 로딩하면 안됨.
        }
        else { // 서버의 모든 이미지를 다 불러온 게 아닌 상황이고,
            if indexPath.item == (artInfoList?.count ?? 0) - 1 && !isLoading { // 사용자 스크롤이 마지막 index면서 로딩중이 아닐 때,
                loadMoreData()
                print("로딩 more Data")
            }
        }
    }
}

// MARK: - Extension PinterestLayoutDelegate

extension HomeListViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        guard let art = artInfoList?[indexPath.item] else { return 0 }
        
        let image = DynamicImage(width: art.width, height: art.height)
        let imgHeight = DeviceUtils.calculateImageHeight(sourceImage: image, scaledToWidth: cellWidth)
        
        let textHeight = requiredHeight(text: art.title, cellWidth: cellWidth)
        
        return imgHeight + textHeight + 5
    }
}
