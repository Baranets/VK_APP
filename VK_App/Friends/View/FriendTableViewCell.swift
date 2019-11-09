//
//  FriendTableViewCell.swift
//  VK_App
//
//  Created by Maxim Baranets on 06.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    class var cellIdentifier: String {
        return "FriendTableViewCell"
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            
            nameLabel.text = user.fullSurname
            onlineLabel.text = user.isOnline ? "online" : "offline"
            onlineLabel.textColor = user.isOnline ? .systemGreen : .systemGray
            
            guard let url = URL(string: user.urlPhotoString ?? "") else { return }
            
            ImageDownloader.shared.downloadImage(fromURL: url, imageCache: nil) { (image) in
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
            }
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
