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
        UIImage(named: "green_cat")!,
        UIImage(named: "artDummy2")!,
        UIImage(named: "artDummy3")!,
        UIImage(named: "artDummy4")!
    ]
    
    var names: [String] = [
        "투리의 고양이", "투리", """
        반려동물을 그리며 즐거움을 느낍니다.
        저는 세개의 달을 가진 검은 고양이를 제 캐릭터로 활용하고 있어요.
        깜깜한 밤 마주친 두개의 고양이 눈이 초승달 처럼 보였던 것에  영감을 받아 제 마스코트가 되었습니다.
        이 냥이는 만물상점을 운영하고 있어요. 제 만물상점엔 모든게 있답니다.
        여러분의 취향, 여러분의 소중한 모든 걸 여기서는 아름답게 전시하고 보여주기 때문이에요.
        """
    ]
    
    var names1: [String] = ["모든 집사들은 집중!", "만물상점", "세상에 단 하나 뿐인 반려동물의 특별한 초상화를 그려드려요! 무지개다리를 건넌 아이, 내 옆에서 자고있는 아이 모두 좋습니다. 이 세상 모든 집사에게 특별한 선물을 안겨보세요!"]
    var names2: [String] = ["먼지의 생활", "모마", "먼지의 먼지나는 생활툰을 간단한 일러스트로 매일매일 받아보세요! 힐링과 감동을 동시에 받아보세요."]
    var names3: [String] = ["오늘은 어린이날!", "코노", "오늘은 어린이날!! 모두가 행복하게, 함께 놀면서 친목을 다져봐요!!"]

    
    
    
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
        
        
//        ArticleAPI.article { [weak self] response in
//            guard let string = response?.result?.thumbnailImage as? String else { return }
//            let url = URL(string: string)
//
//            DispatchQueue.main.async {
//                //self?.imageView.kf.setImage(with: url!)
//                //self?.images[0] = response?.result?.thumbnailImage ?? ""
//                self?.images
//                self?.names[0] = response?.result?.articleTitle ?? ""
//                self?.names[1] = response?.result?.artistName ?? ""
//                self?.names[2] = response?.result?.description ?? ""
//                //self?.textField2.text = response?.result?.description
//            }
//        }
//
        
        
        
        
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
        
        if indexPath.row == 0 {
            cell.fetchText(text: names[0])
            cell.fetchText2(text: names[1])
            cell.fetchText3(text: names[2])
        } else if indexPath.row == 1{
            cell.fetchText(text: names1[0])
            cell.fetchText2(text: names1[1])
            cell.fetchText3(text: names1[2])
        } else if indexPath.row == 2{
            cell.fetchText(text: names2[0])
            cell.fetchText2(text: names2[1])
            cell.fetchText3(text: names2[2])
        } else {
            cell.fetchText(text: names3[0])
            cell.fetchText2(text: names3[1])
            cell.fetchText3(text: names3[2])
        }
       
        
        
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleInfoController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSpacing : CGFloat = 10
//        let itemInset: CGFloat = 20
//
//        let myWidth : CGFloat = (collectionView.bounds.width - itemInset * 0.7 - itemSpacing)/2
//        let myHeight = myWidth + getLabelHeight() + 13
        
        
        return CGSize(width: 300, height: 170)
        //return CGSize(width: 400, height: 270)

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
