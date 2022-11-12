//
//  CustomTabManViewController.swift
//  here-draw-ios
//
//  Created by 성우진 on 2022/11/09.
//

import UIKit
import Tabman
import Pageboy

//protocol PageComponentProtocol where Self: UIViewController {
//    var pageTitle: String { get set }
//}

class CustomTabManViewController: TabmanViewController {
    
    var viewControllers: [UIViewController] = [MyItems(), PurchasedItems()]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabman()
        self.view.backgroundColor = .clear
    }
    
    

    func setupTabman() {
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .clear
        // 간격 설정
        bar.layout.transitionStyle = .snap
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 0
        // 버튼 글씨 커스텀
        bar.buttons.customize { (button) in
            button.backgroundColor = .black
            button.tintColor = .gray
            button.selectedTintColor = .white
            button.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        // 밑줄 쳐지는 부분
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .green
        addBar(bar, dataSource: self, at: .top)
    }
    

}

extension CustomTabManViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "내 작품")
        case 1:
            return TMBarItem(title: "구매한 작품")
        default:
            let title = "Page \(index)"
           return TMBarItem(title: title)
        }
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
