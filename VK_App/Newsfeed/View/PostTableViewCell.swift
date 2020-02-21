//
//  PostTableViewCell.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    func set(post: VKPost, group: VKGroup?) {
        
        postTextLabel.text = post.text
        
        let image = post.likes.userLikes == 1 ?
            UIImage(imageLiteralResourceName: "heart.fill") :
            UIImage(imageLiteralResourceName: "heart")
        likeButton.setImage(image, for: .normal)
        
        likeButton.setTitle(String(post.likes.count), for: .normal)
        repostButton.setTitle(String(post.reposts.count), for: .normal)
        commentButton.setTitle(String(post.comments.count), for: .normal)
        
        if let postURL = (post.attachments?.first?.media as? VKPhoto)?.sizes.last?.photoURL {
            let processor = DownsamplingImageProcessor(size: postImageView.bounds.size)
            postImageView.kf.setImage(
                with: postURL,
                placeholder: UIImage(),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
            ])
        }
        
        guard let group = group else { return }
        groupNameLabel.text = group.name
        if let groupURL = URL(string: group.photo100) {
            let processor = DownsamplingImageProcessor(size: groupImageView.bounds.size)
            groupImageView.kf.setImage(
                with: groupURL,
                placeholder: UIImage(),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
                    .cacheOriginalImage
            ])
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
        let layer = self.groupImageView.layer
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = groupImageView.frame.size.width / 2
    }
    
}
