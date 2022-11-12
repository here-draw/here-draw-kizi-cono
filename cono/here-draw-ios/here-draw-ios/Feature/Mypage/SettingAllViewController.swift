//
//  SettingAllViewController.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/12.
//

import UIKit
import SwiftUI
import SnapKit


class SettingAllViewController: UIViewController {
    
    let set = ["프로필 설정", "로그아웃", "회원탈퇴", "푸시 알림", "이용 약관", "개인정보 처리방침"]
    
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //            $0.tintColor = .white1
            
        }
        let titleLabel = UILabel().then {
            $0.font = .sfPro18Pt2
            $0.textColor = .white1
            $0.text = "설정"
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.titleView = titleLabel
    }
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 설정"
        label.textColor = .white
        label.font = .sfPro16Pt
        return label
    }()
    func titleLabelsetup() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.top.equalToSuperview().offset(107)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    
    private let tableView : UITableView = { // 테이블 뷰 생성
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        return tableView
    }()

    
    
    
    
    
    

    
    let title2Label: UILabel = {
        let label = UILabel()
        label.text = "알림 설정"
        label.textColor = .white
        label.font = .sfPro16Pt
        return label
    }()
    func title2Labelsetup() {
        self.view.addSubview(title2Label)
        title2Label.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.top.equalToSuperview().offset(320)
            make.leading.equalToSuperview().offset(20)
        }
    }
    

    
    private let table2View : UITableView = { // 테이블 뷰 생성
        let table2View = UITableView()
        table2View.translatesAutoresizingMaskIntoConstraints = false
        table2View.register(AlertCell.self, forCellReuseIdentifier: AlertCell.identifier)
        return table2View
    }()
    
    
    
    
    
    let title3Label: UILabel = {
        let label = UILabel()
        label.text = "앱 정보"
        label.textColor = .white
        label.font = .sfPro16Pt
        return label
    }()
    func title3Labelsetup() {
        self.view.addSubview(title3Label)
        title3Label.snp.makeConstraints {(make) in
            //make.width.height.equalTo(151)
            make.top.equalToSuperview().offset(440)
            make.leading.equalToSuperview().offset(20)
        }
    }
    

    
    private let table3View : UITableView = { // 테이블 뷰 생성
        let table3View = UITableView()
        table3View.translatesAutoresizingMaskIntoConstraints = false
        table3View.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        return table3View
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        titleLabelsetup()
        configure()
        addSubView()
        autoLayout()
        title2Labelsetup()
        configure2()
        addSubView2()
        autoLayout2()
        title3Labelsetup()
        configure3()
        addSubView3()
        autoLayout3()
    }
    
    
}

extension SettingAllViewController {
    
    private func configure() {
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.delegate = self
    }
    private func configure2() {
        table2View.dataSource = self
        table2View.rowHeight = 50
        table2View.delegate = self
    }
    private func configure3() {
        table3View.dataSource = self
        table3View.rowHeight = 50
        table3View.delegate = self
    }
    
    private func addSubView() {
        view.addSubview(tableView)
    }
    private func addSubView2() {
        view.addSubview(table2View)
    }
    private func addSubView3() {
        view.addSubview(table3View)
    }
    
    private func autoLayout() {
        
        tableView.separatorStyle = .singleLine
        
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.masksToBounds = true
        
        
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.size.height
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(UIEdgeInsets(top: 60, left: 20, bottom: 490, right: 20))
        }
    }
    private func autoLayout2() {
        
        //tableView.separatorStyle = .singleLine
        table2View.layer.cornerRadius = 10
        table2View.layer.borderWidth = 1
        table2View.layer.masksToBounds = true
        
        table2View.isScrollEnabled = table2View.contentSize.height > table2View.frame.size.height
        table2View.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(UIEdgeInsets(top: 270, left: 20, bottom: 370, right: 20))
        }
    }
    private func autoLayout3() {
        
        //tableView.separatorStyle = .singleLine
        table3View.layer.cornerRadius = 10
        table3View.layer.borderWidth = 1
        table3View.layer.masksToBounds = true
        table3View.isScrollEnabled = table3View.contentSize.height > table3View.frame.size.height
        table3View.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(UIEdgeInsets(top: 400, left: 20, bottom: 190, right: 20))
        }
    }
}


extension SettingAllViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == table2View {
            return 1
        } else if tableView == table3View {
            return 2
        } else {
            return 3
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == table2View {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlertCell.identifier, for: indexPath) as! AlertCell
            cell.label.text = set[3]
            let background = UIView()
            background.backgroundColor = .clear
            cell.selectedBackgroundView = background
            return cell
            
        } else if tableView == table3View {
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
            cell.label.text = set[indexPath.row + 4]
            let background = UIView()
            background.backgroundColor = .clear
            cell.selectedBackgroundView = background
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
            cell.label.text = set[indexPath.row]
            
            let background = UIView()
            background.backgroundColor = .clear
            cell.selectedBackgroundView = background
            return cell

        }
        
    }
}



extension SettingAllViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("select \(indexPath.row)")
    }
}









struct ViewControllerRepresentable4: UIViewControllerRepresentable {
    typealias UIViewControllerType = SettingAllViewController
    
    func makeUIViewController(context: Context) -> SettingAllViewController {
        return SettingAllViewController()
    }
    
    func updateUIViewController(_ uiViewController: SettingAllViewController, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview4: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable4()
    }
}
