//
//  ArticleViewController.swift
//  here-draw-ios
//
//  Created by 박희지 on 2022/10/18.
//

import UIKit
import SwiftUI
import SnapKit

class ArticleViewController: UIViewController {

    
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

  
    
    var images: [UIImage] = [
        UIImage(named: "artDummy1")!,
        UIImage(named: "artDummy2")!,
        UIImage(named: "artDummy3")!,
        UIImage(named: "artDummy4")!
    ]
    
    var names: [String] = [
        "제목", "작가 이름", "본문 90자까지 입력이되며, 길면 줄바꿈 가능"
    ]
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 53
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black1
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    func collectionViewsetup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(UIEdgeInsets(top: 28, left: 20, bottom: 0, right: 20))
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)

        
    }
    
    func getLabelHeight() -> CGFloat {
        let label = UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.sizeToFit()
            $0.font = .sfPro20Pt
        }
        return label.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black1
        setNavigationBar()
        collectionViewsetup()
    }
    



}


extension ArticleViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .none
        cell.fetchImage(image: images[indexPath.item])
        cell.fetchText(text: names[0])
        cell.fetchText2(text: names[1])
        cell.fetchText3(text: names[2])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpacing : CGFloat = 10
//        let itemInset: CGFloat = 20
//
//        let myWidth : CGFloat = (collectionView.bounds.width - itemInset * 0.7 - itemSpacing)/2
//        let myHeight = myWidth + getLabelHeight() + 13
        
        
        return CGSize(width: 300, height: 170)
    }
}


struct ViewControllerRepresentable1: UIViewControllerRepresentable {
    typealias UIViewControllerType = ArticleViewController
    
    func makeUIViewController(context: Context) -> ArticleViewController {
        return ArticleViewController()
    }
    
    func updateUIViewController(_ uiViewController: ArticleViewController, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview1: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable1()
    }
}
