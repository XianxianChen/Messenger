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
    var messages: [Message]?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.title = "Recent"
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        
        setupData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
         return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        if let message = messages?[indexPath.row] {
            cell.message = message
        }
        return cell
    }
  

}
extension FriendController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    
}
class MessageCell: BaseCell{
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            msgLabel.text = message?.text
            if let profileImgName = message?.friend?.profileImageName {
            profileImageView.image = UIImage(named: profileImgName)
                hasReadImageView.image = UIImage(named: profileImgName)
                if let date = message?.date {
            let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    }
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
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend Name"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let msgLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi this is yout fiend xianxian hi there Message Name"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "11:30 pm"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    let hasReadImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.backgroundColor = .green
        imv.layer.cornerRadius = 10
        return imv
    }()
   override func setupViews() {
        backgroundColor = .white
      addSubview(profileImageView)
      addSubview(lineView)
      setupContainerView()

    
/*
     // using anchor constraints:
      profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
      profileImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
     profileImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
    profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
 */
    
    // The Visual Format Language:
    //lets you use ASCII-art like strings to define your constraints. This provides a visually descriptive representation of the constraints.
    addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
    addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
   // addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0(68)]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":profileImageView]))
    
    //NSLayoutConstraint Class:
    //Unlike the approach taken by the layout anchor API, you must specify a value for each parameter, even if it doesn’t affect the layout.
    addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
   
  //  profileImageView.layer.cornerRadius = self.contentView.bounds.height * 0.45
    profileImageView.layer.cornerRadius = 34
    profileImageView.layer.masksToBounds = true
  
    addConstraintsWithFormat(format:  "H:|-82-[v0]|", views: lineView)
    addConstraintsWithFormat(format: "V:[v0(1)]|", views: lineView)
  //  addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":lineView]))
    
    }
    
    private func setupContainerView() {
        let containerView: UIView = {
            let v = UIView()
            return v
        }()
        
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
         addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
         containerView.addSubview(msgLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, msgLabel)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: msgLabel, hasReadImageView)
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
        
    }
}

extension UIView {
    // create function to avoid duplicate codes
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
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
