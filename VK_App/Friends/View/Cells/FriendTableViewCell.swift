//
//  FriendTableViewCell.swift
//  VK_App
//
//  Created by Maxim Baranets on 06.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit
import AlamofireImage

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    var friend: VKFriend? {
        didSet {
            guard let friend = friend else { return }
            
            nameLabel.text = friend.fullSurname
            onlineLabel.text = friend.isOnline ? "online" : "offline"
            onlineLabel.textColor = friend.isOnline ? .systemGreen : .systemGray
            
            guard let url = friend.photoURL else { return }
            userImageView.af_setImage(withURL: url, placeholderImage: UIImage(), progressQueue: DispatchQueue.global(qos: .utility), imageTransition: UIImageView.ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configure() {
        let layer = userImageView.layer
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = userImageView.frame.size.width / 2
    }
    
}
