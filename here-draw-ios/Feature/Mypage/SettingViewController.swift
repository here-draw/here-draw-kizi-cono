//
//  SettingViewController.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import UIKit
import SwiftUI
import SnapKit
import Then
import Tabman
import Pageboy
import Kingfisher


class SettingViewController: UIViewController {

    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        
        self.navigationController?.navigationBar.topItem?.title = ""

        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
//            $0.tintColor = .white1

        }
        let titleLabel = UILabel().then {
            $0.font = .sfPro18Pt2
            $0.text = "프로필 설정"
        }
        let saveButton = UIButton().then {
            $0.titleLabel?.font = .sfPro18Pt2
            $0.setTitle("저장", for: .normal)

        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.titleView = titleLabel
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }

    
    let imageView: UIImageView = {
        let aImageView = UIImageView()
        //aImageView.backgroundColor = .red
        aImageView.image = UIImage(named: "529.png")
        aImageView.layer.cornerRadius = aImageView.frame.width / 2
        aImageView.clipsToBounds = true
        aImageView.contentMode = .scaleAspectFit
        return aImageView
    }()
    func imageViewsetup() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(104)
            //make.left.equalToSuperview().offset(155)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(133)
        }
    }
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize:14)
        //label.font = .sfPro18Pt2
        return label
    }()
    func titleLabelsetup() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(277)
        }
    }
    
    let textField = UITextField().then {
        $0.returnKeyType = .done
//        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = CGFloat(10)
        $0.layer.borderWidth = CGFloat(2)
        $0.layer.borderColor = UIColor.brownishGrey.cgColor
        $0.textColor = .white
        $0.placeholder = "설정한 닉네임"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        
    }
    
    func textFieldsetup() {
        self.view.addSubview(textField)
        textField.snp.makeConstraints {(make) in
            
            make.top.equalToSuperview().offset(304)
            make.leading.equalTo(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(110)
            make.height.equalTo(45)
        }
    }
    
    
    let title2Label: UILabel = {
        let label = UILabel()
        label.text = "중복확인"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize:16)
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 8
        //label.font = .sfPro18Pt2
        label.contentMode = .center
        return label
    }()
    func title2Labelsetup() {
        self.view.addSubview(title2Label)
        title2Label.snp.makeConstraints {(make) in
            make.width.equalTo(80)
            make.height.equalTo(45)
            make.top.equalToSuperview().offset(304)
            make.leading.equalToSuperview().offset(280)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "한글, 영어, 숫자만 사용할 수 있어요. (최대 10자)"
        label.textColor = .brownishGrey
        label.font = UIFont.systemFont(ofSize:11)
        //label.font = .sfPro18Pt2
        return label
    }()
    func titleLabel2setup() {
        self.view.addSubview(titleLabel2)
        titleLabel2.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(359)
            
        }
    }
    

    
    let titleLabel3: UILabel = {
        let label = UILabel()
        label.text = "간단 소개"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize:14)
        //label.font = .sfPro18Pt2
        return label
    }()
    func titleLabel3setup() {
        self.view.addSubview(titleLabel3)
        titleLabel3.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(402)
            
        }
    }
    
    
    
    
    
    
    let textField2 = UITextField().then {
        $0.returnKeyType = .done
//        $0.borderStyle = .roundedRect
        $0.layer.cornerRadius = CGFloat(10)
        $0.layer.borderWidth = CGFloat(2)
        $0.textAlignment = .left
        $0.textColor = .white
        $0.placeholder = "간단 소개"
        $0.layer.borderColor = UIColor.brownishGrey.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: -21, width: 20, height: $0.frame.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        
        
    }
    
    
    func textField2setup() {
        self.view.addSubview(textField2)
        textField2.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(429)
            make.leading.equalTo(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            make.height.equalTo(93)
            

        }
        print("😀 \(self.textField.frame.width)")
    }
    
    
    
    
    let titleLabel4: UILabel = {
        let label = UILabel()
        label.text = "간단한 자기 소개를 입력해주세요. (최대 70자)"
        label.textColor = .brownishGrey
        label.font = UIFont.systemFont(ofSize:11)
        //label.font = .sfPro18Pt2
        return label
    }()
    func titleLabel4setup() {
        self.view.addSubview(titleLabel4)
        titleLabel4.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(532)
            
        }
    }
    
    func fetchProfile() {
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NicknameAPI.profile { [weak self] response in
//            self?.imageView.image = response?.result?.profileImage
            guard let string = response?.result?.profileImage as? String else { return }
            let url = URL(string: string)
            
            DispatchQueue.main.async {
                self?.imageView.kf.setImage(with: url!)
                self?.textField.text = response?.result?.nickname
                self?.textField2.text = response?.result?.description
            }
        }
        
        view.backgroundColor = .black1
        setNavigationBar()
        
        imageViewsetup()
        titleLabelsetup()
        title2Labelsetup()
        textFieldsetup()
        titleLabel2setup()
        titleLabel3setup()
        textField2setup()
        titleLabel4setup()
    }

}




//MARK: - Preview

#if canImport(SwiftUI) && DEBUG

struct ViewRepresentable30: UIViewRepresentable{
    typealias UIViewType = UIView
    private let vc = SettingViewController()
    
    func makeUIView(context: Context) -> UIView {
        vc.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // 데이터 로드 필요할 때
        // vc.tableView.reloadData()
    }
}

struct ViewController_Previews30: PreviewProvider{
    static var previews: some View{
        ViewRepresentable30()
    }
}
#endif
