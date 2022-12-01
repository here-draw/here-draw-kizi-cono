//
//  WishViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit

class WishViewController: UIViewController {

    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        self.navigationController?.navigationBar.topItem?.title = "찜한 그림"
        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //            $0.tintColor = .white1
            
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var containerView: UIView!  //최근 본 작품 뷰
    

    func scrollsetup(){
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = false
            self.view.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(DeviceUtils.width)
                $0.centerX.equalToSuperview()
            }
        }
    }
    func stacksetup() {
        stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 20
            $0.distribution = .fill
            scrollView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
                $0.width.equalToSuperview()
            }
        }
    }
    func uiviewsetup(){
        containerView = UIView().then {
            stackView.addArrangedSubview($0)
//            $0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(160)
            }
        }

    }
    

    //최근 본 작품 라벨
    let Recent_Article: UILabel = {
        let label = UILabel()
        label.text = "최근 본 작품"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro18Pt2
        return label
    }()
    func Recent_Articlesetup() {
        containerView.addSubview(Recent_Article)
        Recent_Article.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(22)
        }
    }
    //기록 지우기 라벨
    let Remove_trace_Label: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "기록 지우기", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.textColor = .mediumGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func Follow_Labelsetup() {
        containerView.addSubview(Remove_trace_Label)
        Remove_trace_Label.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(27)
            
        }
    }
    
    
    //최근 본 작품 컬렉션뷰
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    func collectionViewsetup() {
        containerView.addSubview(collectionView)
//        collectionView.backgroundColor = .red
        collectionView.snp.makeConstraints {
            $0.top.equalTo(Recent_Article.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(RecentCell.self, forCellWithReuseIdentifier: RecentCell.identifier)

    }
    
    var images: [UIImage] = [
        UIImage(named: "a1")!,
        UIImage(named: "a2")!,
        UIImage(named: "a3")!,
        UIImage(named: "a4")!,
        UIImage(named: "a1")!,
        UIImage(named: "a2")!
    ]
    
    func Recent_Article_Setup(){
        Recent_Articlesetup()
        Follow_Labelsetup()
    }
    
    
    //******************************************************************//

    
    private weak var containerView2: UIView!  //찜한 작품 뷰
    func uiview2setup(){
        containerView2 = UIView().then {
            stackView.addArrangedSubview($0)
//            $0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(500)
            }
        }

    }
    
    
    //찜한 작품 라벨
    let Want_Article: UILabel = {
        let label = UILabel()
        label.text = "찜한 작품"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro18Pt2
        return label
    }()
    func Want_Articlesetup() {
        containerView2.addSubview(Want_Article)
        Want_Article.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    //갤러리 추가 버튼
    let Append_Article: UILabel = {
        let label = UILabel()
        label.text = " + 갤러리 추가 "
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func Append_Articlesetup() {
        containerView2.addSubview(Append_Article)
        Append_Article.backgroundColor = .greyishDeepBrown
        Append_Article.layer.borderWidth = 1
        Append_Article.layer.borderColor = UIColor.brownGrey.cgColor
        Append_Article.layer.cornerRadius = 6
        Append_Article.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalTo(Want_Article)
        }
    }

    
    //갤러리 목록 컬렉션뷰
    var collectionView2 : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    func collection2Viewsetup() {
        containerView2.addSubview(collectionView2)
        //collectionView2.backgroundColor = .red
        collectionView2.snp.makeConstraints {
            $0.top.equalTo(Want_Article.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        collectionView2.delegate = self
        collectionView2.dataSource = self

        collectionView2.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.identifier)

    }
    

    func getLabelHeight() -> CGFloat {
        let label = UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "기본 갤러리"
            $0.font = .sfPro14Pt
            $0.sizeToFit()
        }
        return label.frame.height
    }
    
    
    
//
//    //갤러리 추가 버튼을 누르면 나오는 바텀시트
//    private let bottomSheetView: BottomSheetView = {
//        let view = BottomSheetView()
//        view.bottomSheetColor = .lightGray
//        //view.barViewColor = .darkGray
//        return view
//      }()
//
//    func bottomSheetViewSetup(){
//        containerView2.addSubview(bottomSheetView)
//        self.bottomSheetView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        scrollsetup()
        stacksetup()
        uiviewsetup()
        
        
        Recent_Article_Setup()
        collectionViewsetup()
        
        uiview2setup()
        Want_Articlesetup()
        Append_Articlesetup()
        collection2Viewsetup()
    }
    


}



extension WishViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView2 {
            return 1
        } else {
            return 6
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionView2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as? GalleryCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .none
            cell.fetchImage(image: images[0])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCell.identifier, for: indexPath) as? RecentCell else {
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = .none
            cell.fetchImage(image: images[images.count - 1 - indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView2 {
            let itemSpacing : CGFloat = 10
            let itemInset: CGFloat = 20
            
            let myWidth : CGFloat = (collectionView.bounds.width - itemInset * 0.7 - itemSpacing)/2
            let myHeight = myWidth + getLabelHeight() + 13
    //        let myWidth = 182
    //        let myHeight = 182
            
            return CGSize(width: myWidth, height: myHeight)
        } else {
            let itemSpacing : CGFloat = 10
            let itemInset: CGFloat = 20
            
            
            //        let myWidth = 182
            //        let myHeight = 182
            let myWidth : CGFloat = (collectionView.bounds.width - itemSpacing)/4
            let height: CGFloat = myWidth * 10/7 + itemInset + 40
            return CGSize(width: myWidth, height: height)
        }
    }
}
