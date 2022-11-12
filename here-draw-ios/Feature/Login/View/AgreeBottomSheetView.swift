//
//  AgreeBottomSheetView.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/11/08.
//

import UIKit

import SnapKit
import Then

protocol AgreeBottomSheetViewDelegate: UIViewController {
    func pushAgreementVC(title: String)
    func pushOnboardingVC()
}

class AgreeBottomSheetView: PassThroughView {
    // MARK: - Properties
    
    var delegate: AgreeBottomSheetViewDelegate!
    
    var didAllChecked = false {
        didSet {
            allCheckButton.isSelected = didAllChecked
            allCheckButton.layer.borderColor = didAllChecked ? UIColor.pastelYellow.cgColor: UIColor.slateGrey.cgColor
            nextButton.backgroundColor = didAllChecked ? .pastelYellow: .slateGrey
        }
    }
    
    private weak var overlay: UIView!
    private weak var bottomSheetView: UIView!
    private weak var allCheckButton: UIButton!
    private weak var agreeTableView: UITableView!
    private weak var nextButton: UIButton!
    
    private var agreementTermsData = [
        AgreementTerms(opened: false, title: "여기_그림 이용약관 (필수)", sectionData: ["여기_그림 이용약관"], checked: false),
        AgreementTerms(opened: false, title: "개인정보 수집 이용 동의 (필수)", sectionData: ["개인정보 처리방침"], checked: false)
    ]
    
    enum Mode {
        case close
        case full
    }

    private enum Const {
        static let duration = 0.5
        static let cornerRadius = 20.0
        static let bottomSheetRatio: (Mode) -> Double = {
            switch $0 {
            case .close:
                return 1.0
            case .full:
                return 0.52
            }
        }
        
        static let bottomSheetYPosition: (Mode) -> Double = {
            Self.bottomSheetRatio($0) * DeviceUtils.height
        }
    }
    
    var mode: Mode = .full {
        didSet {
            switch self.mode {
            case .close:
                break
            case .full:
                break
            }
            self.updateConstraint(offset: Const.bottomSheetYPosition(self.mode))
            
            if self.mode == .close {
                self.removeFromSuperview()
            }
        }
    }
    var bottomSheetColor: UIColor? {
        didSet { self.bottomSheetView.backgroundColor = self.bottomSheetColor }
    }
    var bottomSheetShadowColor: CGColor? {
        didSet { self.bottomSheetView.layer.shadowColor = self.bottomSheetShadowColor }
    }
    
    
    // MARK: - Function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.shadowColor = nil
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    required init(coder: NSCoder) {
        fatalError("init() has not been implemented")
    }
    
    override func setLayout() {
        overlay = UIView().then {
            $0.backgroundColor = .black
            $0.alpha = 0.6
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        bottomSheetView = UIView().then {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = Const.cornerRadius
            $0.clipsToBounds = true
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.pastelYellow.cgColor
            $0.layer.shadowRadius = 30
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowOffset = CGSize(width: 0, height: -10)
            self.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalTo(Const.bottomSheetYPosition(.full))
                $0.bottom.equalToSuperview()
            }
        }
        
        let titleLabel = UILabel().then {
            $0.text = "약관동의"
            $0.textColor = .white1
            $0.font = .sfPro25Pt2
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().inset(40)
                $0.leading.equalToSuperview().inset(22)
            }
        }
        
        allCheckButton = UIButton().then {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 10.0
            $0.layer.borderColor = UIColor.slateGrey.cgColor
            $0.layer.borderWidth = 2
            
            $0.setTitle("전체 동의", for: .normal)
            $0.setTitleColor(.white1, for: .normal)
            $0.titleLabel?.font = .sfPro18Pt2
            $0.configuration?.imagePlacement = .leading
            $0.imageEdgeInsets = .init(top: 0, left: -200, bottom: 0, right: 0)
            
            $0.setImage(UIImage(named: "checkbox"), for: .normal)
            $0.setImage(UIImage(named: "checkbox_active"), for: .selected)
            $0.setPreferredSymbolConfiguration(.init(pointSize: 24, weight: .regular, scale: .default), forImageIn: .normal)
            $0.tintColor = .mediumGrey
            $0.titleEdgeInsets = .init(top: 0, left: -185, bottom: 0, right: 0)
            
            $0.addTarget(self, action: #selector(allCheckButtonTapped(_:)), for: .touchUpInside)
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(26)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(60)
            }
        }
        
        agreeTableView = UITableView().then {
            $0.dataSource = self
            $0.delegate = self
            $0.separatorStyle = .none
            $0.backgroundColor = .black1
            $0.isScrollEnabled = false
            $0.register(AgreementTableViewCell.self, forCellReuseIdentifier: "cell")
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(allCheckButton.snp.bottom).offset(12)
                $0.leading.trailing.equalToSuperview()
            }
        }
        
        nextButton = UIButton().then {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .slateGrey
            $0.setTitle("다음", for: .normal)
            $0.setTitleColor(.black1, for: .normal)
            $0.titleLabel?.font = .sfPro22Pt
            $0.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
            
            bottomSheetView.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(agreeTableView.snp.bottom).offset(29)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(58)
                $0.bottom.equalToSuperview().inset(35).priority(700)
            }
        }
    }
    
    private func updateConstraint(offset: Double) {
        bottomSheetView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(offset)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func checkAllButton(isSelected: Bool) {
        let indexPath1 = IndexPath.init(row: 0, section: 0)
        let indexPath2 = IndexPath.init(row: 0, section: 1)
        
        guard let cell1 = agreeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath1) as? AgreementTableViewCell else { return }
        guard let cell2 = agreeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath2) as? AgreementTableViewCell else { return }
        
        agreementTermsData[0].checked = isSelected
        agreementTermsData[1].checked = isSelected
        
        cell1.didChecked = isSelected
        cell2.didChecked = isSelected
        
        agreeTableView.reloadData()
    }
    
    private func updateTermsAgreeStatus() {
        didAllChecked = agreementTermsData.allSatisfy { $0.checked }
    }
    
    // MARK: objc func
    @objc
    private func didPan(_ recognizer: UIPanGestureRecognizer) {
        let transitionY = recognizer.translation(in: self).y
        let minY = self.bottomSheetView.frame.minY
        let offset = transitionY + minY
        
        if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.close) ~= offset {
            self.updateConstraint(offset: offset)
            recognizer.setTranslation(.zero, in: self)
        }
        UIView.animate(
            withDuration: 0,
            delay: 0,
            options: .curveEaseOut,
            animations: self.layoutIfNeeded,
            completion: nil
        )
        
        guard recognizer.state == .ended else { return }
        UIView.animate(
            withDuration: Const.duration,
            delay: 0,
            options: .allowUserInteraction,
            animations: {
                // 위로 스와이프, 아래로 스와이프인지 확인
                self.mode = recognizer.velocity(in: self).y >= 0 ? Mode.close: .full
            },
            completion: nil
        )
    }
    
    @objc
    func allCheckButtonTapped(_ sender: UIButton) {
        didAllChecked.toggle()
        checkAllButton(isSelected: didAllChecked)
    }
    
    @objc
    func nextButtonTapped(_ sender: UIButton) {
        if didAllChecked {
            delegate.pushOnboardingVC()
        }
    }
}

// MARK: - Extensin UITableViewDataSource

extension AgreeBottomSheetView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return agreementTermsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if agreementTermsData[section].opened == true {
            // tableView Section이 열려있으면 Section Cell 하나에 sectionData 개수만큼 추가해줘야 함
            return agreementTermsData[section].sectionData.count + 1
        } else {
            // tableView Section이 닫혀있을 경우에는 Section Cell 하나만 보여주면 됨
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 34: 17
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section 부분 코드
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    as? AgreementTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            cell.controlMoreView(isOpened: agreementTermsData[indexPath.section].opened)
            cell.configureSectionUI()
            cell.fetchText(text: agreementTermsData[indexPath.section].title)
            
            
            if didAllChecked {
                cell.didChecked = true
                agreementTermsData[indexPath.section].checked = true
            }
            
            return cell
            
        // sectionData 부분 코드
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    as? AgreementTableViewCell else { return UITableViewCell() }
            cell.configureSectionDataUI()
            cell.fetchText(text: agreementTermsData[indexPath.section].sectionData[indexPath.row - 1])
            
            return cell
        }
    }
}

// MARK: - Extensin UITableViewDelegate

extension AgreeBottomSheetView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 셀 선택 시 회색에서 다시 변하게 해주는 것
        tableView.deselectRow(at: indexPath, animated: true)
        
        // section 부분 선택 시
        if indexPath.row == 0 {
            // section이 열려있다면 다시 닫힐 수 있게 해주는 코드
            agreementTermsData[indexPath.section].opened = !agreementTermsData[indexPath.section].opened
            
            // 모든 데이터를 새로고침하는 것이 아닌 해당하는 섹션 부분만 새로고침
            tableView.reloadSections([indexPath.section], with: .none)
        
        // sectionData 선택 시
        } else {
            let str = agreementTermsData[indexPath.section].sectionData[indexPath.row - 1]
            delegate.pushAgreementVC(title: str)
        }
    }
}

extension AgreeBottomSheetView: AgreementTableViewCellDelegate {
    func checkTerms(didChecked: Bool, index: Int) {
        agreementTermsData[index].checked = didChecked
        updateTermsAgreeStatus()
    }
}




