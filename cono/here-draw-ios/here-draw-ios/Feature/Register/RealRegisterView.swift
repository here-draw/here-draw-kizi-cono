//
//  RealRegisterView.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/14.
//

import UIKit
import SwiftUI
import Then


class RealRegisterView: UIViewController {
    
    
    
    //탭바 설정
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        
        self.navigationController?.navigationBar.topItem?.title = "작품 등록"
        
        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //            $0.tintColor = .white1
            
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    
    
    
    private weak var scrollView: UIScrollView!
    private weak var stackView: UIStackView!
    private weak var containerView: UIView!  //작품명 뷰
    
    
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
                $0.height.equalTo(765)
            }
        }

    }
    
    //******************************************************************//
    
    //경고문 작성
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타인에게 불쾌감을 주거나 비방하는 작품 및 게시글은 \n 삭제 후 회원제재가 이루어질 수 있습니다."
        label.textColor = .pastelYellow
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .sfPro11Pt
        return label
    }()
    func titleLabelsetup() {
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            
        }
    }
    
    //작품명 작성
    let titleName: UILabel = {
        let label = UILabel()
        label.text = "작품명"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func titleNamesetup() {
        containerView.addSubview(titleName)
        titleName.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(titleLabel.snp.bottom).offset(34)
            
        }
    }
    
    //작품명 작성 텍스트필드
    var titleNameTextField = UITextField()
    func textfield() {
        titleNameTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro16Pt
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "작품명을 입력해주세요.",
                attributes:attributes
            )
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(countText), for: .editingChanged)
            containerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalTo(titleName.snp.bottom).offset(10)
                $0.height.equalTo(45)
                
            }
        }
    }
    
    //작품명 겹치는거 경고
    let doubleCheckTitleName: UILabel = {
        let label = UILabel()
        label.text = "중복되는 작품명입니다."
        label.textColor = .grapefruit
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func doubleCheckTitleNamesetup() {
        containerView.addSubview(doubleCheckTitleName)
        doubleCheckTitleName.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(titleNameTextField.snp.bottom).offset(5)
            
        }
    }

    //작품명 글자수 세기
    let titleNameCount: UILabel = {
        let label = UILabel()
        label.text = "0 / 20"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func titleNameCountsetup() {
        containerView.addSubview(titleNameCount)
        titleNameCount.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleNameTextField.snp.bottom).offset(5)
        }
    }
    
    //함수로 묶장
    func ArticleName(){
        titleLabelsetup()
        titleNamesetup()
        textfield()
        titleNameCountsetup()
        doubleCheckTitleNamesetup()
    }
    
    //******************************************************************//
    
    //간단작품설명
    let simpleArticleIntroduce: UILabel = {
        let label = UILabel()
        label.text = "간단 작품 설명"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func simpleArticleIntroducesetup() {
        containerView.addSubview(simpleArticleIntroduce)
        simpleArticleIntroduce.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(doubleCheckTitleName.snp.bottom).offset(19)
            
        }
    }
    
    
    //간단작품설명 텍스트필드
    var simpleArticleIntroduceTextField = UITextField()
    func simpleArticleIntroducetextField() {
        simpleArticleIntroduceTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro16Pt
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "간단하게 작품을 설명해주세요.",
                attributes:attributes
            )
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(countText), for: .editingChanged)
            containerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalTo(simpleArticleIntroduce.snp.bottom).offset(10)
                $0.height.equalTo(68)
                
            }
        }
    }
    
    //간단작품설명 글자수 세기
    let simpleArticleIntroduceCount: UILabel = {
        let label = UILabel()
        label.text = "0 / 50"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func simpleArticleIntroduceCountsetup() {
        containerView.addSubview(simpleArticleIntroduceCount)
        simpleArticleIntroduceCount.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(simpleArticleIntroduceTextField.snp.bottom).offset(5)
        }
    }

    //함수로 묶장
    func ArticleIntro(){
        
        simpleArticleIntroducesetup()
        simpleArticleIntroducetextField()
        simpleArticleIntroduceCountsetup()
    }
    
    //******************************************************************//

    
    //가격
    let PriceLabel: UILabel = {
        let label = UILabel()
        label.text = "가격"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func PriceLabelsetup() {
        containerView.addSubview(PriceLabel)
        PriceLabel.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(simpleArticleIntroduceTextField.snp.bottom).offset(30)
            
        }
    }
    
    //가격 텍스트필드
    var PriceTextField = UITextField()
    func PriceTextFieldsetup() {
        PriceTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro16Pt
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "작품 가격을 정해주세요.",
                attributes:attributes
            )
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(countText), for: .editingChanged)
            containerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalTo(PriceLabel.snp.bottom).offset(10)
                $0.height.equalTo(45)
                
            }
        }
    }
    
    let PriceLabelCount: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro16Pt
        return label
    }()
    func PriceLabelCountsetup() {
        containerView.addSubview(PriceLabelCount)
        PriceLabelCount.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(PriceLabel.snp.bottom).offset(23)
        }
    }
    
    //함수로 묶장
    func PriceFunc(){
        PriceLabelsetup()
        PriceTextFieldsetup()
        PriceLabelCountsetup()
    }
    
    //******************************************************************//
    
    
    //독점 구매
    let greedyBuy: UILabel = {
        let label = UILabel()
        label.text = "독점구매"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func greedyBuysetup() {
        containerView.addSubview(greedyBuy)
        greedyBuy.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(PriceTextField.snp.bottom).offset(30)
        }
    }
    
    //가격 텍스트필드
    var greedyBuyTextField = UITextField()
    func greedyBuyTextFieldsetup() {
        greedyBuyTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro16Pt
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "추가할 가격을 정해주세요.",
                attributes:attributes
            )
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(countText), for: .editingChanged)
            containerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalTo(greedyBuy.snp.bottom).offset(14)
                $0.height.equalTo(45)
                
            }
        }
    }
    
    let greedyBuyCount: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro16Pt
        return label
    }()
    func greedyBuyCountsetup() {
        containerView.addSubview(greedyBuyCount)
        greedyBuyCount.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(greedyBuy.snp.bottom).offset(27)
        }
    }
    
    //함수로 묶장
    func GreedyFunc(){
        greedyBuysetup()
        greedyBuyTextFieldsetup()
        greedyBuyCountsetup()
    }
    
    //******************************************************************//

    //수량
    let CountPiece: UILabel = {
        let label = UILabel()
        label.text = "수량"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func CountPiecesetup() {
        containerView.addSubview(CountPiece)
        CountPiece.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(greedyBuyTextField.snp.bottom).offset(30)
        }
    }
    
    //수량 텍스트필드
    var CountPieceTextField = UITextField()
    func CountPieceTextFieldsetup() {
        CountPieceTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro16Pt
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "1~9,999로 입력해주세요.",
                attributes:attributes
            )
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(countText), for: .editingChanged)
            containerView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalTo(CountPiece.snp.bottom).offset(10)
                $0.height.equalTo(45)
                
            }
        }
    }
    
    let CountPieceCount: UILabel = {
        let label = UILabel()
        label.text = "0개"
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro16Pt
        return label
    }()
    func CountPieceCountsetup() {
        containerView.addSubview(CountPieceCount)
        CountPieceCount.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(CountPiece.snp.bottom).offset(22)
        }
    }
    
    //함수로 묶장
    func CountPieceFunc(){
        CountPiecesetup()
        CountPieceTextFieldsetup()
        CountPieceCountsetup()
    }
    
    //******************************************************************//
    
    //허용범위
    let allowRange: UILabel = {
        let label = UILabel()
        label.text = "허용 범위"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func allowRangesetup() {
        containerView.addSubview(allowRange)
        allowRange.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(CountPieceTextField.snp.bottom).offset(30)
        }
    }
    
    
    let button1: UIButton = {
        let button = UIButton()
        button.setTitle("개인 사용", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func button1setup() {
        containerView.addSubview(button1)
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.mediumGrey.cgColor
        button1.layer.cornerRadius = 16
        button1.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(allowRange.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(94)

            
        }
    }
    
    let button2: UIButton = {
        let button = UIButton()
        button.setTitle("상업적 이용", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func button2setup() {
        containerView.addSubview(button2)
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.mediumGrey.cgColor
        button2.layer.cornerRadius = 16
        button2.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(button1.snp.trailing).offset(10)
            make.top.equalTo(allowRange.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(109)

            
        }
    }
    
    let button3: UIButton = {
        let button = UIButton()
        button.setTitle("2차 가공 허용", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func button3setup() {
        containerView.addSubview(button3)
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.mediumGrey.cgColor
        button3.layer.cornerRadius = 16
        button3.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(button2.snp.trailing).offset(10)
            make.top.equalTo(allowRange.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(122)

            
        }
    }
    
    let button4: UIButton = {
        let button = UIButton()
        button.setTitle("재배포 허용", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func button4setup() {
        containerView.addSubview(button4)
        button4.layer.borderWidth = 1
        button4.layer.borderColor = UIColor.mediumGrey.cgColor
        button4.layer.cornerRadius = 16
        button4.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(button1.snp.bottom).offset(10)
            make.height.equalTo(32)
            make.width.equalTo(109)
        }
    }
    
    func AllowRangeFunc(){
        allowRangesetup()
        button1setup()
        button2setup()
        button3setup()
        button4setup()
    }
    
    //******************************************************************//

    //회색바 뷰를 넣음
    private weak var greyView: UIView!
    func greyViewsetup(){
        greyView = UIView().then {
            stackView.addArrangedSubview($0)
            $0.backgroundColor = .greyishMediumBrown
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                //$0.top.equalToSuperview().offset(1000)
                $0.height.equalTo(10)
                
            }
        }
    }
    
    //******************************************************************//
    
    //작품 설명 뷰
    private weak var ArticleIntroduceView: UIView!
    func ArticleIntroduceViewsetup(){
        ArticleIntroduceView = UIView().then {
            stackView.addArrangedSubview($0)
            //$0.backgroundColor = .gray

            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(77)
            }
        }
    }
    
    //작품설명 라벨 추가함
    let Introduce_label: UILabel = {
        let label = UILabel()
        label.text = "작품 설명"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func Introduce_labelsetup() {
        ArticleIntroduceView.addSubview(Introduce_label)
        Introduce_label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalToSuperview().inset(30)
        }
    }
    
    //작품설명 더보기 버튼
    let Introduce_btn: UIButton = {
        let button = UIButton()
        //button.setTitle("개인 사용", for: .normal)
        button.tintColor = .white1
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        return button
    }()
    func Introduce_btnsetup() {
        ArticleIntroduceView.addSubview(Introduce_btn)
        Introduce_btn.addTarget(self, action: #selector(ToArticleIntroduceView), for: .touchUpInside)
        Introduce_btn.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20.9)
            make.top.equalToSuperview().inset(30)
        }
    }
    
    

    
    //함수로 묶는 부분
    func ArticleSetup(){
        ArticleIntroduceViewsetup()
        Introduce_labelsetup()
        Introduce_btnsetup()
    }
    
    
    //******************************************************************//
    
    
    //파일 유형 선택 뷰
    private weak var FileTypeSelectView: UIView!
    func FileTypeSelectViewsetup(){
        FileTypeSelectView = UIView().then {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(180)
            }
        }
    }
    
    //작품설명 라벨 추가함
    let FileTypeSelect_label: UILabel = {
        let label = UILabel()
        label.text = "파일 유형 선택"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func FileTypeSelect_labelsetup() {
        FileTypeSelectView.addSubview(FileTypeSelect_label)
        FileTypeSelect_label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalToSuperview().inset(30)
        }
    }
    
    
    //파일 타입 버튼 6개
    
    let JPG_btn: UIButton = {
        let button = UIButton()
        button.setTitle("JPG", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func JPG_btnsetup() {
        FileTypeSelectView.addSubview(JPG_btn)
        JPG_btn.layer.borderWidth = 1
        JPG_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        JPG_btn.layer.cornerRadius = 16
        JPG_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(FileTypeSelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(64)

            
        }
    }
        
    let PNG_btn: UIButton = {
        let button = UIButton()
        button.setTitle("PNG", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func PNG_btnsetup() {
        FileTypeSelectView.addSubview(PNG_btn)
        PNG_btn.layer.borderWidth = 1
        PNG_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        PNG_btn.layer.cornerRadius = 16
        PNG_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(JPG_btn.snp.trailing).offset(10)
            make.top.equalTo(FileTypeSelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
    }
    
    let SVG_btn: UIButton = {
        let button = UIButton()
        button.setTitle("SVG", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func SVG_btnsetup() {
        FileTypeSelectView.addSubview(SVG_btn)
        SVG_btn.layer.borderWidth = 1
        SVG_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        SVG_btn.layer.cornerRadius = 16
        SVG_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(PNG_btn.snp.trailing).offset(10)
            make.top.equalTo(FileTypeSelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
    }
    
    let Ai_btn: UIButton = {
        let button = UIButton()
        button.setTitle("AI", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func Ai_btnsetup() {
        FileTypeSelectView.addSubview(Ai_btn)
        Ai_btn.layer.borderWidth = 1
        Ai_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Ai_btn.layer.cornerRadius = 16
        Ai_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(SVG_btn.snp.trailing).offset(10)
            make.top.equalTo(FileTypeSelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
    }
    
    let PSD_btn: UIButton = {
        let button = UIButton()
        button.setTitle("PSD", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func PSD_btnsetup() {
        FileTypeSelectView.addSubview(PSD_btn)
        PSD_btn.layer.borderWidth = 1
        PSD_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        PSD_btn.layer.cornerRadius = 16
        PSD_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(JPG_btn.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
    }
    
    let PDF_btn: UIButton = {
        let button = UIButton()
        button.setTitle("PDF", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func PDF_btnsetup() {
        FileTypeSelectView.addSubview(PDF_btn)
        PDF_btn.layer.borderWidth = 1
        PDF_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        PDF_btn.layer.cornerRadius = 16
        PDF_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(PSD_btn.snp.trailing).offset(10)
            make.top.equalTo(JPG_btn.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
    }
    
    
    //함수로 묶자
    func FileTypeSetup(){
        FileTypeSelectViewsetup()
        FileTypeSelect_labelsetup()
        JPG_btnsetup()
        PNG_btnsetup()
        SVG_btnsetup()
        Ai_btnsetup()
        PSD_btnsetup()
        PDF_btnsetup()
    }
    
    
    
    
    //******************************************************************//
    
    //카테고리 선택 뷰
    private weak var CategorySelectView: UIView!
    func CategorySelectViewsetup(){
        CategorySelectView = UIView().then {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(200)
            }
        }
    }
    
    //작품설명 라벨 추가함
    let CategorySelect_label: UILabel = {
        let label = UILabel()
        label.text = "카테고리 선택"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func CategorySelect_labelsetup() {
        CategorySelectView.addSubview(CategorySelect_label)
        CategorySelect_label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalToSuperview().inset(30)
        }
    }
    
    let btn1: UIButton = {
        let button = UIButton()
        button.setTitle("캐릭터", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func btn1setup() {
        CategorySelectView.addSubview(btn1)
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.mediumGrey.cgColor
        btn1.layer.cornerRadius = 16
        btn1.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(CategorySelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(76)

            
        }
    }
    
    let btn2: UIButton = {
        let button = UIButton()
        button.setTitle("풍경화", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func btn2setup() {
        CategorySelectView.addSubview(btn2)
        btn2.layer.borderWidth = 1
        btn2.layer.borderColor = UIColor.mediumGrey.cgColor
        btn2.layer.cornerRadius = 16
        btn2.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(btn1.snp.trailing).offset(10)
            make.top.equalTo(CategorySelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(76)

            
        }
    }
    
    let btn3: UIButton = {
        let button = UIButton()
        button.setTitle("만화", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func btn3setup() {
        CategorySelectView.addSubview(btn3)
        btn3.layer.borderWidth = 1
        btn3.layer.borderColor = UIColor.mediumGrey.cgColor
        btn3.layer.cornerRadius = 16
        btn3.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(btn2.snp.trailing).offset(10)
            make.top.equalTo(CategorySelect_label.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(76)

            
        }
    }
    
    let btn4: UIButton = {
        let button = UIButton()
        button.setTitle("인물화", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func btn4setup() {
        CategorySelectView.addSubview(btn4)
        btn4.layer.borderWidth = 1
        btn4.layer.borderColor = UIColor.mediumGrey.cgColor
        btn4.layer.cornerRadius = 16
        btn4.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(btn1.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(76)

            
        }
    }
    
    let btn5: UIButton = {
        let button = UIButton()
        button.setTitle("기타", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func btn5setup() {
        CategorySelectView.addSubview(btn5)
        btn5.layer.borderWidth = 1
        btn5.layer.borderColor = UIColor.mediumGrey.cgColor
        btn5.layer.cornerRadius = 16
        btn5.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalTo(btn4.snp.trailing).offset(10)
            make.top.equalTo(btn1.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(76)

            
        }
    }
    
    
    //함수로 묶자
    func CategorySelectViewSetup(){
        CategorySelectViewsetup()
        CategorySelect_labelsetup()
        btn1setup()
        btn2setup()
        btn3setup()
        btn4setup()
        btn5setup()
    }
    
    
    
    //******************************************************************//

    
    //해시태그 생성 뷰
    private weak var HashTagView: UIView!
    func HashTagViewsetup(){
        HashTagView = UIView().then {
            stackView.addArrangedSubview($0)
//            $0.backgroundColor = .gray
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(200)
            }
        }
    }
    
    //해시태그 라벨 추가
    let HashTag_label: UILabel = {
        let label = UILabel()
        label.text = "작품 해시태그"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func HashTag_labelsetup() {
        HashTagView.addSubview(HashTag_label)
        HashTag_label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalToSuperview().inset(30)
        }
    }
    
    //해시태그 더보기 버튼
    let HashTag_btn: UIButton = {
        let button = UIButton()
        //button.setTitle("개인 사용", for: .normal)
        button.tintColor = .white1
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        return button
    }()
    func HashTag_btnsetup() {
        HashTagView.addSubview(HashTag_btn)
//        Introduce_btn.layer.borderWidth = 1
//        Introduce_btn.layer.borderColor = UIColor.mediumGrey.cgColor
//        Introduce_btn.layer.cornerRadius = 16
        HashTag_btn.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20.9)
            make.top.equalToSuperview().inset(20.9)
        }
    }
    
    //해시태그 텍스트필드
    var HashTagTextField = UITextField()
    func HashTagTextFieldsetup() {
        HashTagTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro14Pt
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "#을 임의로 붙이지 않아도 자동생성됩니다.",
                attributes:attributes
            )
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(countText), for: .editingChanged)
            HashTagView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(20)
                $0.trailing.equalToSuperview().inset(75)
                $0.top.equalTo(HashTag_label.snp.bottom).offset(20)
                $0.height.equalTo(45)
                
            }
        }
    }
    
    //해시태그 추가하기 버튼
    let HashTag_Plus_btn: UIButton = {
        let button = UIButton()
        button.tintColor = .white1
        //button.backgroundColor = .white1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    func HashTag_Plus_btnsetup() {
        HashTagView.addSubview(HashTag_Plus_btn)
        HashTag_Plus_btn.layer.borderWidth = 1
        HashTag_Plus_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        HashTag_Plus_btn.layer.cornerRadius = 10
        
        HashTag_Plus_btn.addTarget(self, action: #selector(PlusHashTagButton), for: .touchUpInside)
        HashTag_Plus_btn.snp.makeConstraints {(make) in
            make.leading.equalTo(HashTagTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalTo(HashTagTextField)
            //make.height.width.equalTo(45)
        }
    }
    
    let Hashbtn: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func Hashbtnsetup() {
        HashTagView.addSubview(Hashbtn)
        Hashbtn.layer.borderWidth = 1
        Hashbtn.layer.borderColor = UIColor.mediumGrey.cgColor
        Hashbtn.layer.cornerRadius = 16
        Hashbtn.addTarget(self, action: #selector(MinusHashTagButton), for: .touchUpInside)
        Hashbtn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(HashTagTextField.snp.bottom).offset(20)
            make.height.equalTo(32)
            make.width.equalTo(95)
        }
    }
    
    //해시태그 라벨 추가
    let HashTagInfo_label: UILabel = {
        let label = UILabel()
        label.text = "- 해시태그는 최대 15자로 입력할 수 있으며 10개까지 등록 할 수 있습니다."
        label.textColor = .brownGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func HashTagInfo_labelsetup() {
        HashTagView.addSubview(HashTagInfo_label)
        HashTagInfo_label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            //make.trailing.equalToSuperview().inset(68)

            make.top.equalTo(HashTagTextField.snp.bottom).offset(70)
        }
    }
    
    
    
    //함수로 묶자...
    func HashTagViewSetup() {
        HashTagViewsetup()
        HashTag_labelsetup()
        HashTag_btnsetup()
        HashTagTextFieldsetup()
        HashTag_Plus_btnsetup()
        HashTagInfo_labelsetup()
    }
    

    
    //******************************************************************//

    
    
    //임시저장 및 업로드 뷰
    
    private weak var SaveView: UIView!
    func SaveViewsetup(){
        SaveView = UIView().then {
            stackView.addArrangedSubview($0)
//            $0.backgroundColor = .gray
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(85)
            }
        }
    }
    
    let Save_btn: UIButton = {
        let button = UIButton()
        button.setTitle("임시저장", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func Save_btnsetup() {
        SaveView.addSubview(Save_btn)
        Save_btn.layer.borderWidth = 1
        Save_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Save_btn.layer.cornerRadius = 10
        //Save_btn.addTarget(self, action: #selector(colorChange), for: .touchUpInside)

        Save_btn.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(190)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    let Upload_btn: UIButton = {
        let button = UIButton()
        button.setTitle("업로드", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        return button
    }()
    func Upload_btnsetup() {
        SaveView.addSubview(Upload_btn)
        Upload_btn.layer.borderWidth = 1
        Upload_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        Upload_btn.layer.cornerRadius = 10
        Upload_btn.addTarget(self, action: #selector(ChangeColor), for: .touchUpInside)
        Upload_btn.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(Save_btn.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)

        }
    }
    
    
    //함수로 묶자!
    func SaveViewSetup(){
        SaveViewsetup()
        Save_btnsetup()
        Upload_btnsetup()
    }
    
    
    
    
    
    //******************************************************************//
    
    
    
    
    
    
    
    
    
    //해시태그 텍스트필드 입력후 플러스 버튼 누르면 해시태그 버튼 생성
    @objc func PlusHashTagButton() {
        var s1: String = HashTagTextField.text ?? ""
        Hashbtn.setTitle("#\(s1) x", for: .normal)
        Hashbtnsetup()
    }
    
    //해시태그한거 버튼 눌러서 다시 지우깅
    @objc func MinusHashTagButton() {
        Hashbtn.removeFromSuperview()
    }

    
    //텍스트필드의 숫자 세는 함수
    @objc func countText() {
        
        // 작품명 글자 수 20자 넘으면 입력 불가
        if titleNameTextField.text?.count ?? 0 > 20 {
            titleNameTextField.deleteBackward()
        }
        if simpleArticleIntroduceTextField.text?.count ?? 0 > 50 {
            simpleArticleIntroduceTextField.deleteBackward()
        }
        if HashTagTextField.text?.count ?? 0 > 15 {
            HashTagTextField.deleteBackward()
        }
        
        if PriceTextField.text?.count ?? 0 > -1 {
            PriceLabelCount.text = (PriceTextField.text ?? "0") + "원"
            //PriceTextField.textColor = .black1
        }
        if greedyBuyTextField.text?.count ?? 0 > -1 {
            greedyBuyCount.text = (greedyBuyTextField.text ?? "0") + "원"
            //PriceTextField.textColor = .black1
        }
        
        if CountPieceTextField.text?.count ?? 0 > -1 {
            CountPieceCount.text = (CountPieceTextField.text ?? "0") + "개"
            if CountPieceTextField.text?.count ?? 0 > 4 {
                CountPieceTextField.deleteBackward()
            }
            
        }
        
        var a1: Int = titleNameTextField.text?.count ?? 0
        var a2: Int = simpleArticleIntroduceTextField.text?.count ?? 0
        titleNameCount.text = "\(a1) / 20"
        simpleArticleIntroduceCount.text = "\(a2) / 50"

    }
    
    //작품 설명 뷰로 보내기
    @objc func ToArticleIntroduceView() {
        self.navigationController?.pushViewController(here_draw_ios.ArticleIntroduceView(), animated: false)
    }
    
    
    //버튼 누르면 색상 바뀌는 함수      //수정이 필요함..
    @objc func ChangeColor() {
        if Upload_btn.isTouchInside == false {
            Upload_btn.setTitleColor(.white1, for: .normal)
            Upload_btn.backgroundColor = .greyishMediumBrown
        } else {
            Upload_btn.setTitleColor(.black, for: .normal)
            Upload_btn.backgroundColor = .pastelYellow
        }
    }
    

    
    
//    class ButtonWithHighlight: UIButton {
//
//        override var isTouchInside: Bool {
//            get {
//                return super.isTouchInside
//            }
//            set {
//                backgroundColor = UIColor.pastelYellow
//                //super.isTouchInside = newValue
//            }
//        }
//
//    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        scrollsetup()
        stacksetup()
        uiviewsetup()
        
        
        ArticleName()
        ArticleIntro()
        PriceFunc()
        GreedyFunc()
        CountPieceFunc()
        AllowRangeFunc()
        
        greyViewsetup()
        
        ArticleSetup()
        
        greyViewsetup()
        
        FileTypeSetup()
        
        greyViewsetup()
        
        CategorySelectViewSetup()
        
        greyViewsetup()
        
        HashTagViewSetup()
        
        SaveViewSetup()
    }
    


}






struct ViewControllerRepresentable56: UIViewControllerRepresentable {
    typealias UIViewControllerType = RealRegisterView
    
    func makeUIViewController(context: Context) -> RealRegisterView {
        return RealRegisterView()
    }
    
    func updateUIViewController(_ uiViewController: RealRegisterView, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview56: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable56()
    }
}
