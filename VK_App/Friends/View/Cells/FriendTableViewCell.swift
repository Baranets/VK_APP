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
    
    weak var tableView: UITableView?
    weak var queue: OperationQueue?
    var indexPath: IndexPath?
    
    weak var friend: VKFriend? {
        didSet {
            guard let friend = friend else { return }
            
            nameLabel.text = friend.fullSurname
            onlineLabel.text = friend.isOnline ? "online" : "offline"
            onlineLabel.textColor = friend.isOnline ? .systemGreen : .systemGray
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
