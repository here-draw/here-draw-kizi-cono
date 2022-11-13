//
//  OnboardingViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/12.
//

import UIKit

import SnapKit
import Then

class OnboardingViewController: BaseViewController {
    
    // MARK: - Properties
    
    let viewModel = OnboardingViewModel()
    var isValidString: Bool = false {
        didSet {
            if !isValidString {
                nicknameTextField.layer.borderColor = UIColor.brownGrey.cgColor
                doubleCheckButton.layer.borderColor = UIColor.brownGrey.cgColor
                resultLabel.isHidden = false
                doubleCheckButton.isEnabled = false
                nextButton.isEnabled = false
                resultLabel.text = "유효하지 않은 형식입니다."
                resultLabel.textColor = .grapefruit
            } else {
                resultLabel.isHidden = true
                doubleCheckButton.isEnabled = true
            }
        }
    }
    var availableNickname: Bool = false {
        didSet {
            if availableNickname {
                nicknameTextField.layer.borderColor = UIColor.pastelYellow.cgColor
                doubleCheckButton.layer.borderColor = UIColor.pastelYellow.cgColor
                resultLabel.textColor = .pastelYellow
                nextButton.isEnabled = true
                nextButton.backgroundColor = .pastelYellow
            } else {
                nicknameTextField.layer.borderColor = UIColor.grapefruit.cgColor
                doubleCheckButton.layer.borderColor = UIColor.grapefruit.cgColor
                resultLabel.textColor = .grapefruit
                nextButton.isEnabled = false
                nextButton.backgroundColor = .greyishDeepBrown
            }
        }
    }
    
    private weak var nicknameTextField: UITextField!
    private weak var doubleCheckButton: UIButton!
    private weak var resultLabel: UILabel!
    private weak var nextButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setNavigationBar()
        dismissKeyboardByTouching()
        controlNextButtonByKeyboard()
    }
    
    // MARK: - Functions
    
    func controlNextButtonByKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustNextButtonHeight), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustNextButtonHeight), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func setLayout() {
        let descriptionLabel = UILabel().then {
            $0.text = "닉네임을\n입력해주세요"
            $0.font = .sfPro35Pt
            $0.textColor = .white
            $0.numberOfLines = 2
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).inset(80)
                $0.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
        }
        
        let subDescriptionLabel = UILabel().then {
            $0.text = "한글,영어,숫자만 사용할 수 있어요. (최대 10자)"
            $0.font = .sfPro11Pt5
            $0.textColor = .brownGrey
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(35)
                $0.leading.equalTo(descriptionLabel.snp.leading).offset(5)
            }
        }
        
        doubleCheckButton = UIButton().then {
            $0.layer.cornerRadius = 10
            $0.setTitle("중복확인", for: .normal)
            $0.titleLabel?.font = .sfPro18Pt2
            $0.setTitleColor(.brownGrey, for: .normal)
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 2
            $0.isEnabled = false
            $0.addTarget(self, action: #selector(doubleCheckButtonTapped(_:)), for: .touchUpInside)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(subDescriptionLabel.snp.bottom).offset(10)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
                $0.width.equalTo(95)
                $0.height.equalTo(60)
            }
        }
        
        nicknameTextField = UITextField().then {
            $0.layer.borderColor = UIColor.brownGrey.cgColor
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.brownGrey,
                NSAttributedString.Key.font : UIFont.sfPro18Pt2
            ]
            $0.attributedPlaceholder = NSAttributedString(
                string: "닉네임을 입력해주세요",
                attributes:attributes
            )
            $0.font = .sfPro18Pt2
            $0.textColor = .white
            
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: $0.frame.height))
            $0.leftViewMode = .always
            $0.addTarget(self, action: #selector(checkTextField), for: .editingChanged)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(subDescriptionLabel.snp.bottom).offset(10)
                $0.leading.equalTo(descriptionLabel.snp.leading)
                $0.trailing.equalTo(doubleCheckButton.snp.leading).inset(UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0))
                $0.height.equalTo(60)
            }
        }
        
        resultLabel = UILabel().then {
            $0.text = "중복확인의 결과가 뜨는 레이블"
            $0.font = .sfPro11Pt5
            $0.textColor = .grapefruit
            $0.isHidden = true
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
                $0.leading.equalTo(subDescriptionLabel.snp.leading)
            }
        }
        
        nextButton = UIButton().then {
            $0.backgroundColor = .greyishDeepBrown
            $0.layer.cornerRadius = 10
            $0.setTitle("다음", for: .normal)
            $0.titleLabel?.font = .sfPro22Pt
            $0.setTitleColor(.black, for: .normal)
            $0.isEnabled = false
            $0.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(35)
                $0.height.equalTo(58)
            }
        }
    }
    
    @objc
    func checkTextField() {
        isValidString = false
        // 글자 수 10자 넘으면 입력 불가
        if nicknameTextField.text?.count ?? 0 > 10 {
            nicknameTextField.deleteBackward()
        }
        
        // 유효한 문자인지 검사(by 정규식)
        let regex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{1,10}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        isValidString = test.evaluate(with: nicknameTextField.text ?? "")
    }
    
    @objc
    func doubleCheckButtonTapped(_ sender: UIButton) {
        // TODO: 뷰모델로부터 중복 검사 api 연결
        guard let nickname = nicknameTextField.text else { return }
        viewModel.doubleCheckNickname(nickname: nickname) { (available, message) in
            self.availableNickname = available
            self.resultLabel.text = message
            self.resultLabel.isHidden = false
        }
    }
    
    @objc
    func nextButtonTapped(_ sender: UIButton) {
        guard let nickname = nicknameTextField.text else { return }
        viewModel.setNickname(nickname: nickname) { (isSuccess, message) in
            if isSuccess {
                self.gotoMain()
            }
            else {
                self.showToast(message: message)
            }
        }
    }
    
    @objc
    func adjustNextButtonHeight(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        nextButton.snp.remakeConstraints {
            let iskeyboardUp = noti.name == UIResponder.keyboardWillShowNotification
            let adjustmentHeight = iskeyboardUp ? keyboardFrame.height - view.safeAreaInsets.bottom + 10: 35
            
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().inset(adjustmentHeight)
            $0.height.equalTo(58)
        }
    }
}
