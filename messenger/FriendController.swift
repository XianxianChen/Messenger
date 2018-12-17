//
//  ViewController.swift
//  messenger
//
//  Created by C4Q on 12/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FriendController: UICollectionViewController {
private let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
  

}
extension FriendController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    
}
class FriendCell: BaseCell{
    let profileImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.backgroundColor = .yellow

        return imv
    }()
    let lineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return v
    }()
   override func setupViews() {
        backgroundColor = .white
      addSubview(profileImageView)
      addSubview(lineView)
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    lineView.translatesAutoresizingMaskIntoConstraints = false
/*
      profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
      profileImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
     profileImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
    profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
 */
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(68)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[v0(68)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":profileImageView]))
  //  profileImageView.layer.cornerRadius = self.contentView.bounds.height * 0.45
    profileImageView.layer.cornerRadius = 34
    profileImageView.layer.masksToBounds = true
  
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":lineView]))
       addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":lineView]))
    }
}
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    func setupViews() {
        backgroundColor = .blue
    }
}
