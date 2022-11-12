//
//  ArticleInfoController.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/12.
//

import UIKit
import SwiftUI

//메인화면에서 아티클 배너 이미지를 누르면 들어오는 뷰
class ArticleInfoController: UIViewController {

    //전체 스크롤뷰 선언
    
    private weak var scrollView: UIScrollView!

    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        
        self.navigationController?.navigationBar.topItem?.title = ""

        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
//            $0.tintColor = .white1

        }
        let titleLabel = UILabel().then {
            $0.font = .sfPro25Pt2
            $0.textColor = .pastelYellow
            $0.text = "ARTICLE COMPILATION"
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.titleView = titleLabel
    }
    
    func scrollsetup(){
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = true
            self.view.addSubview($0)
            $0.backgroundColor = .red
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(DeviceUtils.width)
                $0.centerX.equalToSuperview()

            }
        }
    }

    let imageView: UIImageView = {
        let aImageView = UIImageView()
        //aImageView.backgroundColor = .red
        aImageView.image = UIImage(named: "artDummy3")
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    func imageViewsetup() {
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(114)
            make.trailing.leading.equalTo(scrollView)
            make.height.equalTo(590)
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "9월 첫번째 아티스트"
        label.textColor = .lightGray
        label.font = .sfPro17Pt
        return label
    }()
    func titleLabelsetup() {
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            make.leading.trailing.equalTo(139)
            make.top.equalTo(imageView.snp.bottom).offset(41)
        }
    }
    
    let titleLabe2: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .lightGray
        label.font = .sfPro25Pt2
        return label
    }()
    func title2Labelsetup() {
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            make.leading.trailing.equalTo(139)
            make.top.equalTo(titleLabel.snp.bottom).offset(41)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollsetup()
        setNavigationBar()
        imageViewsetup()
        titleLabelsetup()
        title2Labelsetup()
        
    }

}












struct ViewControllerRepresentable3: UIViewControllerRepresentable {
    typealias UIViewControllerType = ArticleInfoController
    
    func makeUIViewController(context: Context) -> ArticleInfoController {
        return ArticleInfoController()
    }
    
    func updateUIViewController(_ uiViewController: ArticleInfoController, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview3: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable3()
    }
}
