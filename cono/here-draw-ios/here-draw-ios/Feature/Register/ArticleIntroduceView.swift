//
//  ArticleIntroduceView.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/18.
//

import UIKit
import SwiftUI
import Then

class ArticleIntroduceView: UIViewController {

    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        self.navigationController?.navigationBar.topItem?.title = "작품 설명"
        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //            $0.tintColor = .white1
            
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    
    
    private weak var stackView: UIStackView!
    private weak var containerView: UIView!

    func stacksetup() {
        stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.distribution = .fill
            self.view.addSubview($0)
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
                $0.height.equalTo(100)
            }
        }

    }


    //작품이미지라벨
    let titleName: UILabel = {
        let label = UILabel()
        label.text = "작품이미지"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func titleNamesetup() {
        containerView.addSubview(titleName)
        titleName.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalToSuperview().inset(112)
            
        }
    }
    
    //작품 등록 이미지 버튼
    let photo_btn: UIButton = {
        let button = UIButton()
        //button.setTitle("임시저장", for: .normal)
        button.setTitleColor(.white1, for: .normal)
        //button.backgroundColor = .gray
        return button
    }()
    func photo_btnsetup() {
        containerView.addSubview(photo_btn)
        photo_btn.layer.borderWidth = 2
        photo_btn.layer.borderColor = UIColor.mediumGrey.cgColor
        photo_btn.layer.cornerRadius = 10
        //Save_btn.addTarget(self, action: #selector(colorChange), for: .touchUpInside)

        photo_btn.snp.makeConstraints {(make) in
            make.width.height.equalTo(100)
            make.leading.equalToSuperview().offset(22)
            make.top.equalTo(titleName.snp.bottom).offset(20)
        }
    }
    
    
    //해시태그 라벨 추가
    let photo_btn_Info_label: UILabel = {
        let label = UILabel()
        label.text = "작품 최대 용량은 50MB를 넘길 수 없습니다."
        label.textColor = .mediumGrey
        label.textAlignment = .left
        label.font = .sfPro11Pt
        return label
    }()
    func photo_btn_Info_labelsetup() {
        containerView.addSubview(photo_btn_Info_label)
        photo_btn_Info_label.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            //make.trailing.equalToSuperview().inset(68)

            make.top.equalTo(photo_btn.snp.bottom).offset(8)
        }
    }
    
    
    //작품이미지라벨
    let title_introduce: UILabel = {
        let label = UILabel()
        label.text = "작품 설명"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .sfPro14Pt
        return label
    }()
    func title_introducesetup() {
        containerView.addSubview(title_introduce)
        title_introduce.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.top.equalTo(photo_btn_Info_label.snp.bottom).offset(28)
            
        }
    }
    
    
    
    
    
    let textViewPlaceHolder = "작품 설명을 작성해주세요"
    lazy var textView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.mediumGrey.cgColor
        view.layer.cornerRadius = 10
        //view.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        view.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        view.font = .sfPro11Pt
        view.text = textViewPlaceHolder
        view.textColor = .brownGrey
        view.delegate = self
        
        return view
    }()
    lazy var remainCountLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "0 / 1000"
            label.font = .sfPro11Pt
            label.textColor = .brownGrey
            label.textAlignment = .left

            return label
        }()

    func textViewsetup(){
        view.addSubview(textView)
        view.addSubview(remainCountLabel)
        
        textView.snp.makeConstraints {(make) in
            make.leading.equalToSuperview().inset(22)
            make.trailing.equalToSuperview().inset(22)
            make.top.equalTo(title_introduce.snp.bottom).offset(18)
            make.height.equalTo(370)
        }
        remainCountLabel.snp.makeConstraints {(make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(textView.snp.bottom).offset(5)
            make.height.equalTo(13)
            //make.width.equalTo(43)

        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        stacksetup()
        uiviewsetup()
        titleNamesetup()
        photo_btnsetup()
        photo_btn_Info_labelsetup()
        title_introducesetup()
        
        textViewsetup()
        
        
        
        
    }
    
    @objc
    private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }
    private func updateCountLabel(characterCount: Int) {
        remainCountLabel.text = "\(characterCount) / 1000"
//        remainCountLabel.asColor(targetString: "\(characterCount)", color: characterCount == 0 ? .lightGray : .blue)
        remainCountLabel.asColor(targetString: "\(characterCount)", color: characterCount == 0 ? .lightGray : .white1)
    }

}










extension ArticleIntroduceView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .white1
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
            updateCountLabel(characterCount: 0)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)

        let characterCount = newString.count
        guard characterCount <= 1000 else { return false }
        updateCountLabel(characterCount: characterCount)

        return true
    }
}

extension UILabel {
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: color as Any, range: range)
        attributedText = attributedString
    }
}




































struct ArticleIntroduceView1: UIViewControllerRepresentable {
    typealias UIViewControllerType = ArticleIntroduceView
    
    func makeUIViewController(context: Context) -> ArticleIntroduceView {
        return ArticleIntroduceView()
    }
    
    func updateUIViewController(_ uiViewController: ArticleIntroduceView, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ArticleIntroduceViewPreview: PreviewProvider {
    static var previews: some View {
        ArticleIntroduceView1()
    }
}



