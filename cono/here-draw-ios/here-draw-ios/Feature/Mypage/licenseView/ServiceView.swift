//
//  ServiceView.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/12.
//

import UIKit
import SwiftUI

class ServiceView: UIViewController {

    
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
            $0.text = "서비스 약관 동의"
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.titleView = titleLabel
    }
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "여기_그림 서비스 이용약관"
        label.textColor = .white
        label.font = .sfPro18Pt2
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
    
    
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    func scrollsetup() {
        self.view.addSubview(contentScrollView)
        self.view.backgroundColor = .red
        
    }
    
    
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        titleLabelsetup()
        scrollsetup()
    }
    


}







struct ViewControllerRepresentable5: UIViewControllerRepresentable {
    typealias UIViewControllerType = ServiceView
    
    func makeUIViewController(context: Context) -> ServiceView {
        return ServiceView()
    }
    
    func updateUIViewController(_ uiViewController: ServiceView, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview5: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable5()
    }
}
