//
//  chatLogController.swift
//  messenger
//
//  Created by C4Q on 12/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let cellId = "msgId"
    var friend: Friend? {
        didSet {
          
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages?.sort(by: {$0.date!.compare($1.date! as Date) == .orderedAscending})

        }
    }
    var messages: [Message]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
         collectionView.backgroundColor = .white
        collectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellId)
      let backButton = UIBarButtonItem()
        backButton.title = "back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    
  
    }
//    @objc func dismiss() {
//        self.dismiss()
//    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        if let count = messages?.count {
        return count
        } else {return 0}
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.row].text
        if let message = messages?[indexPath.row], let messageText = message.text, let profileImageName = message.friend?.profileImageName {
            let size = CGSize.init(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesLineFragmentOrigin
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
            if !message.isSender {
            
         cell.messageTextView.frame = CGRect(origin: CGPoint(x: 48 + 8, y: 0), size:  CGSize(width: estimatedFrame.width + 16, height: estimatedFrame.height + 25))
           cell.textBubbleView.frame = CGRect(origin: CGPoint(x: 48 , y: 0), size:  CGSize(width: estimatedFrame.width + 16 + 8 , height: estimatedFrame.height + 25))
            cell.profileImageView.image = UIImage(named: profileImageName)
            cell.profileImageView.isHidden = false
            //cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            cell.messageTextView.textColor = .black
                cell.bubbleImageView.image = ChatLogMessageCell.grayBubbleImage
                 cell.bubbleImageView.tintColor = UIColor(white: 0.9, alpha: 1)

            } else {
               
                cell.messageTextView.frame = CGRect(origin: CGPoint(x: view.frame.width - estimatedFrame.width - 16 - 8 , y: 0), size:  CGSize(width: estimatedFrame.width + 16, height: estimatedFrame.height + 25))
                cell.textBubbleView.frame = CGRect(origin: CGPoint(x: view.frame.width - estimatedFrame.width - 16 - 8 - 8, y: 0), size:  CGSize(width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 25))
                 cell.profileImageView.isHidden = true
                //cell.textBubbleView.backgroundColor = UIColor(displayP3Red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = .white
                cell.bubbleImageView.image = ChatLogMessageCell.blueBubbleImage
                
                 cell.bubbleImageView.tintColor = UIColor(displayP3Red: 0, green: 137/255, blue: 249/255, alpha: 1)

            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageText = messages?[indexPath.row].text {
           let size = CGSize.init(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesLineFragmentOrigin
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 25)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    
}



class ChatLogMessageCell: BaseCell {
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Sample message"
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
   lazy var textBubbleView: UIView = {
        let view = UIView()
       // view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    lazy var profileImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.backgroundColor = .red
        imv.layer.cornerRadius = 15
        imv.layer.masksToBounds = true
        return imv
    }()
    
    static let blueBubbleImage =  UIImage(named: "bubble_blue")?.resizableImage(withCapInsets:  UIEdgeInsets(top: 25, left: 30, bottom: 25,right: 30)).withRenderingMode(.alwaysTemplate)
    static let grayBubbleImage =  UIImage(named: "bubble_gray")?.resizableImage(withCapInsets:  UIEdgeInsets(top: 25, left: 30, bottom: 25,right: 30)).withRenderingMode(.alwaysTemplate)
    
    lazy var bubbleImageView: UIImageView = {
       let imv = UIImageView()
        imv.image = UIImage(named: "bubble_gray")?.resizableImage(withCapInsets:  UIEdgeInsets(top: 25, left: 30, bottom: 25,right: 30)).withRenderingMode(.alwaysTemplate)
       
        imv.tintColor = UIColor(white: 0.9, alpha: 1)
        return imv
    }()
    override func setupViews() {
        super.setupViews()
       // backgroundColor = .gray
       // messageTextView.translatesAutoresizingMaskIntoConstraints = false
         addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(30)]|", views: profileImageView)
        
        textBubbleView.addSubview(bubbleImageView)
        textBubbleView.addConstraintsWithFormat(format: "H:|[v0]|", views: bubbleImageView)
        textBubbleView.addConstraintsWithFormat(format: "V:|[v0]|", views: bubbleImageView)
        
    }
}
