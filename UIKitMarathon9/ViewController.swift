//
//  ViewController.swift
//  UIKitMarathon9
//
//  Created by alexeituszowski on 25.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 230, height: 450)
        layout.sectionInsetReference = .fromLayoutMargins
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
            let target = targetContentOffset.pointee
            let center = CGPoint(x: target.x + collectionView.bounds.width / 2, y: target.y + collectionView.bounds.height / 2)
            
            guard let indexPath = collectionView.indexPathForItem(at: center) else { return }
            guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
            
            let insets = collectionView.contentInset
            let itemSize = attributes.frame.size
            let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
            let newX = round((target.x - insets.left) / (itemSize.width + spacing)) * (itemSize.width + spacing) + insets.left
            
            targetContentOffset.pointee = CGPoint(x: newX, y: target.y)
        }
        
}

