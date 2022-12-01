//
//  MypageViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit
import SwiftUI
import SnapKit
import Then
import Tabman
import Pageboy


class MypageViewController: TabmanViewController {

    private let nickname = "leesyum"
    
    
    let buttonView: UIButton = {
        let buttonView = UIButton()
        //aImageView.backgroundColor = .red
        buttonView.setImage(UIImage(named: "settings"), for: .normal)
        buttonView.addTarget(self, action: #selector(goSetting(_:)), for: .touchUpInside)
        return buttonView
    }()
    func buttonViewsetup() {
        view.addSubview(buttonView)
        buttonView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    

    @objc func goSetting(_ sender: UIButton) {
        
        let nextVC = SettingAllViewController()
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    let imageView: UIImageView = {
        let aImageView = UIImageView()
        //aImageView.backgroundColor = .red
        aImageView.image = UIImage(named: "529.png")
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    func imageViewsetup() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(104)
            make.left.equalToSuperview().offset(27)
            make.top.equalTo(self.buttonView.snp.bottom).offset(24)
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "leesyum"
        label.textColor = .white
        label.font = .sfPro18Pt2
        return label
    }()
    func titleLabelsetup() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.left.equalToSuperview().offset(151)
            make.top.equalTo(self.buttonView.snp.bottom).offset(45)
            
        }
    }
    
    let followerLabel: UILabel = {
        let followerLabel = UILabel()
        followerLabel.text = "팔로워"
        followerLabel.textColor = .white
        followerLabel.font = UIFont.systemFont(ofSize:11)
        return followerLabel
    }()
    func followerLabelsetup() {
        self.view.addSubview(followerLabel)
        followerLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(151)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(13)
            
        }
    }
    
    let followerCountLabel: UILabel = {
        let followerCountlabel = UILabel()
        followerCountlabel.text = "0"
        followerCountlabel.textColor = .white
        followerCountlabel.font = UIFont.systemFont(ofSize:14)
        return followerCountlabel
    }()
    func followerCountLabelsetup() {
        self.view.addSubview(followerCountLabel)
        followerCountLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(151)
            make.top.equalTo(self.followerLabel.snp.bottom).offset(3)
            
        }
    }

    let followingLabel: UILabel = {
        let followingLabel = UILabel()
        followingLabel.text = "팔로잉"
        followingLabel.textColor = .white
        followingLabel.font = UIFont.systemFont(ofSize:11)
        return followingLabel
    }()
    func followingLabelsetup() {
        self.view.addSubview(followingLabel)
        followingLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(211)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(13)
            
        }
    }
    
    let followingCountLabel: UILabel = {
        let followingCountLabel = UILabel()
        followingCountLabel.text = "0"
        followingCountLabel.textColor = .white
        followingCountLabel.font = UIFont.systemFont(ofSize:14)
        return followingCountLabel
    }()
    func followingCountLabelsetup() {
        self.view.addSubview(followingCountLabel)
        followingCountLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(211)
            make.top.equalTo(self.followingLabel.snp.bottom).offset(3)
            
        }
    }
    
    
    let ContentsDibsLabel: UILabel = {
        let ContentsDibsLabel = UILabel()
        ContentsDibsLabel.text = "작품 찜"
        ContentsDibsLabel.textColor = .white
        ContentsDibsLabel.font = UIFont.systemFont(ofSize:11)
        return ContentsDibsLabel
    }()
    func ContentsDibsLabelsetup() {
        self.view.addSubview(ContentsDibsLabel)
        ContentsDibsLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(271)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(13)
        }
    }
    
    let ContentsDibsCountLabel: UILabel = {
        let ContentsDibsCountLabel = UILabel()
        ContentsDibsCountLabel.text = "0"
        ContentsDibsCountLabel.textColor = .white
        ContentsDibsCountLabel.font = UIFont.systemFont(ofSize:14)
        return ContentsDibsCountLabel
    }()
    func ContentsDibsCountLabelsetup() {
        self.view.addSubview(ContentsDibsCountLabel)
        ContentsDibsCountLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(271)
            make.top.equalTo(self.ContentsDibsLabel.snp.bottom).offset(3)
            
        }
    }
    
    
    let IntroduceLabel: UILabel = {
        let IntroduceLabel = UILabel()
        IntroduceLabel.text = "간단 자기 소개 (최대 70자)"
        IntroduceLabel.textColor = .white
        IntroduceLabel.font = UIFont.systemFont(ofSize:11)
        //label.font = .sfPro18Pt2
        return IntroduceLabel
    }()
    func IntroduceLabelsetup() {
        self.view.addSubview(IntroduceLabel)
        IntroduceLabel.snp.makeConstraints {(make) in
            make.left.equalToSuperview().offset(27)
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(52)
        }
    }

    //탭바 컨텐츠를 나타낼 뷰 선언
//    let ContentsView = UIView()
//    func ContentsViewsetup() {
//        ContentsView.backgroundColor = .black
//        ContentsView.snp.makeConstraints {(make) in
//            make.top.equalTo(self.IntroduceLabel.snp.bottom).offset(28)
////            make.size.equalTo(CGSize(width: self.view.frame.width, height: 50))
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
    
    
//    private var viewControllers: [UIViewController] = []

//    func setupTabman() {
//
//        let firstVC = NewViewController()
//        let secondVC = PurchasedViewController()
//        viewControllers.append(firstVC)
//        viewControllers.append(secondVC)
//        self.dataSource = self
//        let bar = TMBar.ButtonBar()
//        bar.backgroundView.style = .clear
//        // 간격 설정
//        bar.layout.transitionStyle = .snap
//        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        bar.layout.contentMode = .fit
//        bar.layout.interButtonSpacing = 0
//        // 버튼 글씨 커스텀
//        bar.buttons.customize { (button) in
//            button.backgroundColor = .black
//            button.tintColor = .gray
//            button.selectedTintColor = .white
//            button.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        }
//        // 밑줄 쳐지는 부분
//        bar.indicator.weight = .custom(value: 2)
//        bar.indicator.tintColor = .green
//        addBar(bar, dataSource: self, at: .custom(view: ContentsView, layout: nil))
//    }
    
    func addContainerView() {
        let tabManVC = CustomTabManViewController()
        self.addChild(tabManVC)
        view.addSubview(tabManVC.view)
        tabManVC.view.snp.makeConstraints {
            $0.top.equalTo(self.IntroduceLabel.snp.bottom).offset(28)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        tabManVC.didMove(toParent: self)
    }

    
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //view.backgroundColor = .black1
        buttonViewsetup()

        imageViewsetup()
        titleLabelsetup()
        followerLabelsetup()
        followerCountLabelsetup()
        followingLabelsetup()
        followingCountLabelsetup()
        ContentsDibsLabelsetup()
        ContentsDibsCountLabelsetup()
        IntroduceLabelsetup()
        addContainerView()
//        ContentsViewsetup()
        //setupTabman()
        
    }
    



}













struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MypageViewController
    
    func makeUIViewController(context: Context) -> MypageViewController {
        return MypageViewController()
    }
    
    func updateUIViewController(_ uiViewController: MypageViewController, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
