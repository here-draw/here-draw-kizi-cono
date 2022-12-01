//
//  BaseGalleryView.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/18.
//

import UIKit



//갤러리 목록 페이지를 나타내는 뷰


class BaseGalleryView: UIViewController {

    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white1
        self.navigationController?.navigationBar.topItem?.title = "기본 갤러리"
        let backButton = UIButton().then {
            $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
            //            $0.tintColor = .white1
            
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    


}
