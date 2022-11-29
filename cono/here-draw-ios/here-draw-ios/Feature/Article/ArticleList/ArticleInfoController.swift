//
//  ArticleInfoController.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/12.
//

import UIKit
import SwiftUI
import Then


//메인화면에서 아티클 배너 이미지를 누르면 들어오는 뷰
class ArticleInfoController: UIViewController {

    //전체 스크롤뷰 선언
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
            $0.text = "WEEKLY ART-ICLE"
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.titleView = titleLabel
    }
    
    
    
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var containerView: UIView!  //아티클 상세 뷰
    private weak var containerView2: UIView! //회색선 뷰
    private weak var containerView3: UIView! //회색선 뷰
    
    
    
    
    
    
    
    
    
    
    func scrollsetup(){
        scrollView = UIScrollView().then {
            $0.showsVerticalScrollIndicator = false
            self.view.addSubview($0)
            //$0.backgroundColor = .red
            
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
                $0.width.equalTo(DeviceUtils.width)
                $0.centerX.equalToSuperview()

            }
        }
    }

    func stacksetup() {
        stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 10
            $0.distribution = .fill
            scrollView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(1700)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    func uiviewsetup(){
        containerView = UIView().then {
            stackView.addArrangedSubview($0)
//            $0.backgroundColor = .blue
            $0.snp.makeConstraints {
//                $0.leading.trailing.equalToSuperview()
                //$0.height.equalTo(1300)
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview().inset(500)
                $0.leading.trailing.equalToSuperview()
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
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.leading.equalTo(containerView)
            make.height.equalTo(590)
            
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "9월 첫번째 아티스트"
        label.textColor = .white
        label.font = .sfPro17Pt
        return label
    }()
    func titleLabelsetup() {
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(41)
            //make.top.equalToSuperview()
        }
    }

    let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "투리"
        label.textColor = .white
        label.font = .sfPro25Pt2
        return label
    }()
    func title2Labelsetup() {
        containerView.addSubview(titleLabel2)
        titleLabel2.snp.makeConstraints {(make) in
            //make.leading.trailing.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(29)
        }
    }
    
    
    let titleLabel3: UILabel = {
        let label = UILabel()
        label.text = """
        반려동물을 그리며 즐거움을 느낍니다.
        저는 세개의 달을 가진 검은 고양이를 제 캐릭터로 활용하고 있어요.
        깜깜한 밤 마주친 두개의 고양이 눈이 초승달 처럼 보였던 것에  영감을 받아 제 마스코트가 되었습니다.
        이 냥이는 만물상점을 운영하고 있어요. 제 만물상점엔 모든게 있답니다.
        여러분의 취향, 여러분의 소중한 모든 걸 여기서는 아름답게 전시하고 보여주기 때문이에요.
        """
        label.textColor = .white
        label.textAlignment = .center
        label.font = .sfPro18Pt2
        return label
    }()
    func titleLabel3setup() {
        containerView.addSubview(titleLabel3)
        titleLabel3.numberOfLines = 22
//        titleLabel3.backgroundColor = .red
        titleLabel3.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel2.snp.bottom).offset(40)
            make.trailing.leading.equalToSuperview().inset(40)
            make.height.equalTo(400)
        }
    }
    
    
    
    
    func uiview2setup(){
        containerView2 = UIView().then {
            stackView.addArrangedSubview($0)
            $0.backgroundColor = .gray
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(1)
                
            }
        }
    }
    
    func uiview3setup(){
        containerView3 = UIView().then {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
//                $0.leading.trailing.equalToSuperview()
                //$0.top.equalTo(containerView2.snp.bottom).offset(10)
                $0.height.equalTo(100)
                //$0.bottom.equalToSuperview().offset(500)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
    
    
    
    
    

    let titleLabel4: UILabel = {
        let label = UILabel()
        label.text = "작가의 다른 작품들이예요"
        label.textColor = .white
        label.font = .sfPro18Pt2
        return label
    }()
    func title4Labelsetup() {
        containerView3.addSubview(titleLabel4)
        titleLabel4.snp.makeConstraints {(make) in
            make.leading.equalTo(21)
            
            make.top.equalToSuperview().offset(29)
        }
    }
    
    
    
    let image2View: UIImageView = {
        let aImageView = UIImageView()
        //aImageView.backgroundColor = .red
        aImageView.image = UIImage(named: "artDummy3")
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    func image2Viewsetup() {
        containerView3.addSubview(image2View)
        image2View.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel4.snp.bottom).offset(20)
            make.height.width.equalTo(157)
            make.leading.equalTo(20)
        }
    }
    
    let image3View: UIImageView = {
        let aImageView = UIImageView()
        //aImageView.backgroundColor = .red
        aImageView.image = UIImage(named: "artDummy3")
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    func image3Viewsetup() {
        containerView3.addSubview(image3View)
        image3View.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel4.snp.bottom).offset(20)
            make.height.width.equalTo(157)
            make.leading.equalTo(image2View.snp.trailing).offset(20)
        }
    }
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("작가님 작품 더보기", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func button4setup() {
        containerView3.addSubview(button)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 15

        button.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.top.equalTo(image3View.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
            make.width.equalTo(374)
            make.height.equalTo(58)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        scrollsetup()
        stacksetup()
        uiviewsetup()
        imageViewsetup()
        titleLabelsetup()
        title2Labelsetup()
        titleLabel3setup()
        
        uiview2setup()
        
        
        
        uiview3setup()
        title4Labelsetup()
        image2Viewsetup()
        image3Viewsetup()
        button4setup()
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
struct ViewPreview33: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable3()
    }
}
