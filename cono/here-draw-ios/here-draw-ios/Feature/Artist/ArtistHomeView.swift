//
//  ArtistHomeView.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/13.
//

import UIKit
import SwiftUI

class ArtistHomeView: UIViewController {
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        self.navigationController?.navigationBar.topItem?.title = ""
        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //            $0.tintColor = .white1
            
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var containerView: UIView!  //작가홈뷰
    

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
            $0.spacing = 5
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
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(330)
            }
        }

    }
    
    
    //작가홈 프로필
    let imageView: UIImageView = {
        let aImageView = UIImageView()
        //aImageView.backgroundColor = .red
        aImageView.image = UIImage(named: "529.png")
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    func imageViewsetup() {
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(104)
            //make.leading.equalToSuperview().offset(155)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(22)
        }
    }
    
    //일러스트레이터 이름
    let Name: UILabel = {
        let label = UILabel()
        label.text = "일러스트레이터 이름"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro18Pt
        return label
    }()
    func Namesetup() {
        containerView.addSubview(Name)
        Name.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(22)
            
        }
    }
    
    //팔로워 라벨
    let Follow_Label: UILabel = {
        let label = UILabel()
        label.text = "팔로워"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func Follow_Labelsetup() {
        containerView.addSubview(Follow_Label)
        Follow_Label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().offset(100)
            make.top.equalTo(Name.snp.bottom).offset(11)
            
        }
    }
    //팔로워 수
    let Follow_Count: UILabel = {
        let label = UILabel()
        label.text = "2.9만"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro16Pt
        return label
    }()
    func Follow_Countsetup() {
        containerView.addSubview(Follow_Count)
        Follow_Count.snp.makeConstraints {(make) in
            make.leading.equalTo(Follow_Label.snp.trailing).offset(11)
            make.top.equalTo(Name.snp.bottom).offset(7)

        }
    }
    
    //작품 찜
    let Want_Label: UILabel = {
        let label = UILabel()
        label.text = "작품 찜"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func Want_Labelsetup() {
        containerView.addSubview(Want_Label)
        Want_Label.snp.makeConstraints {(make) in
            make.leading.equalTo(Follow_Count.snp.trailing).offset(15)
            make.top.equalTo(Name.snp.bottom).offset(11)
            
        }
    }
    //작품 찜 수
    let Want_Count: UILabel = {
        let label = UILabel()
        label.text = "1.9천"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro16Pt
        return label
    }()
    func Want_Countsetup() {
        containerView.addSubview(Want_Count)
        Want_Count.snp.makeConstraints {(make) in
            make.leading.equalTo(Want_Label.snp.trailing).offset(12)
            make.top.equalTo(Name.snp.bottom).offset(7)

        }
    }
    
    //작가 간단 소개
    let SimpleIntroduce_Label: UILabel = {
        let label = UILabel()
        label.text = "최대 70자까지"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sfPro11Pt
        return label
    }()
    func SimpleIntroduce_Labelsetup() {
        containerView.addSubview(SimpleIntroduce_Label)
//        SimpleIntroduce_Label.backgroundColor = .red
        SimpleIntroduce_Label.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(340)
            make.height.equalTo(27)
            make.top.equalTo(Name.snp.bottom).offset(39)
            
        }
    }
    
    
    //팔로우 버튼
    let Follow_btn: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .pastelYellow
        return button
    }()
    func Follow_btnsetup() {
        containerView.addSubview(Follow_btn)
        //Follow_btn.layer.borderWidth = 1
        //Follow_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Follow_btn.layer.cornerRadius = 10
        //Save_btn.addTarget(self, action: #selector(colorChange), for: .touchUpInside)

        Follow_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(SimpleIntroduce_Label.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(140)
        }
    }
    
    
    //메시지 버튼
    let Message_btn: UIButton = {
        let button = UIButton()
        button.setTitle("메시지", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .tea
        return button
    }()
    func Message_btnsetup() {
        containerView.addSubview(Message_btn)
        //Follow_btn.layer.borderWidth = 1
        //Follow_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Message_btn.layer.cornerRadius = 10
        //Save_btn.addTarget(self, action: #selector(colorChange), for: .touchUpInside)

        Message_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(Follow_btn.snp.trailing).offset(7)
            make.top.equalTo(SimpleIntroduce_Label.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(140)
        }
    }
    
    //아티클 버튼
    let Article_Go_btn: UIButton = {
        let button = UIButton()
        //button.setTitle("메시지", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .butterscotch
//        button.setImage(UIImage(named: "widthdoc"), for: .normal)

        return button
    }()
    func Article_Go_btnsetup() {
        containerView.addSubview(Article_Go_btn)
        //Follow_btn.layer.borderWidth = 1
        //Follow_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Article_Go_btn.layer.cornerRadius = 10
        //Save_btn.addTarget(self, action: #selector(colorChange), for: .touchUpInside)

        Article_Go_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(Message_btn.snp.trailing).offset(7)
            make.top.equalTo(SimpleIntroduce_Label.snp.bottom).offset(30)
            make.height.width.equalTo(40)
            
        }
    }
    
    //회색바 뷰를 넣음
    private weak var greyView: UIView!
    func greyViewsetup(){
        greyView = UIView().then {
            stackView.addArrangedSubview($0)
            $0.backgroundColor = .mediumGrey
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                //$0.top.equalToSuperview().offset(1000)
                $0.height.equalTo(1)
                
            }
        }
    }
    
    
    
    
    func containerViewSetup(){
        imageViewsetup()
        Namesetup()
        Follow_Labelsetup()
        Follow_Countsetup()
        Want_Labelsetup()
        Want_Countsetup()
        SimpleIntroduce_Labelsetup()
        Follow_btnsetup()
        Message_btnsetup()
        Article_Go_btnsetup()
        
        greyViewsetup()
    }
    
    //******************************************************************//

    
    
    private weak var containerView2: UIView!  //작가홈 작품 뷰

    func uiview2setup(){
        containerView2 = UIView().then {
            stackView.addArrangedSubview($0)
            //$0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(60)
            }
        }

    }
    
    
    //체크박스 버튼
    let Check_btn: UIButton = {
        let button = UIButton()
        //button.setTitle("메시지", for: .normal)
        //button.setTitleColor(.black, for: .normal)
        //button.backgroundColor = .butterscotch
        return button
    }()
    func Check_btnsetup() {
        containerView2.addSubview(Check_btn)
        Check_btn.layer.borderWidth = 1
        Check_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Check_btn.layer.cornerRadius = 2
        //Save_btn.addTarget(self, action: #selector(colorChange), for: .touchUpInside)

        Check_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(19.5)
            make.top.equalToSuperview().offset(20)
            
            make.height.width.equalTo(15)
            
        }
    }
    //이미지만 보기 라벨
    let Only_image_Label: UILabel = {
        let label = UILabel()
        label.text = "이미지만 보기"
        label.textColor = .mediumGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func Only_image_Labelsetup() {
        containerView2.addSubview(Only_image_Label)
        Only_image_Label.snp.makeConstraints {(make) in
            make.leading.equalTo(Check_btn.snp.trailing).offset(6)
            make.top.equalToSuperview().offset(22)
        }
    }
    
    
    func containerView2Setup(){
        Check_btnsetup()
        Only_image_Labelsetup()
    }

    //******************************************************************//

    
    private weak var containerView3: UIView!  //작가홈 작품 컬렉션뷰를 넣을 뷰

    func uiview3setup(){
        containerView3 = UIView().then {
            stackView.addArrangedSubview($0)
//            $0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(500)
            }
        }

    }
    
   
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
        containerView3.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ArticleListCell.self, forCellWithReuseIdentifier: ArticleListCell.identifier)

    }
    
    
    
    
    var images: [UIImage] = [
        UIImage(named: "a1")!,
        UIImage(named: "a2")!,
        UIImage(named: "a3")!,
        UIImage(named: "a4")!
    ]
    
    var names: [String] = ["작품제목"]
    
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
        setNavigationBar()
        scrollsetup()
        stacksetup()
        uiviewsetup()
        
        containerViewSetup()
        
        
        
        
        uiview2setup()
        
        containerView2Setup()
        
        uiview3setup()
        collectionViewsetup()
        
    }
    


}










extension ArtistHomeView : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleListCell.identifier, for: indexPath) as? ArticleListCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .none
        cell.fetchImage(image: images[images.count - 1 - indexPath.item])
        cell.fetchText(text: names[0])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 10
        let itemInset: CGFloat = 20
        
        let myWidth : CGFloat = (collectionView.bounds.width - itemInset * 0.7 - itemSpacing)/2
        let myHeight = myWidth + getLabelHeight() + 13
//        let myWidth = 182
//        let myHeight = 182
        
        return CGSize(width: myWidth, height: myHeight)
    }
}





































struct ViewControllerRepresentable123: UIViewControllerRepresentable {
    typealias UIViewControllerType = ArtistHomeView
    
    func makeUIViewController(context: Context) -> ArtistHomeView {
        return ArtistHomeView()
    }
    
    func updateUIViewController(_ uiViewController: ArtistHomeView, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview123: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable123()
    }
}
