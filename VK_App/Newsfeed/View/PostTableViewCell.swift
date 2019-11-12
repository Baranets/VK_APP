//
//  PostTableViewCell.swift
//  VK_App
//
//  Created by Maxim Baranets on 11.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    class var cellIdentifier: String {
        return "PostTableViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    

    
    func set(post: Post, group: Group?) {
        
        postTextLabel.text = post.text
        
        let image = post.likes.isLiked ? UIImage(imageLiteralResourceName: "heart.fill") : UIImage(imageLiteralResourceName: "heart")
        likeButton.setImage(image, for: .normal)
        
        likeButton.setTitle(String(post.likes.count), for: .normal)
        repostButton.setTitle(String(post.reposts.count), for: .normal)
        commentButton.setTitle(String(post.comments.count), for: .normal)
        
        let imageIndex = post.attachments[0].sizes.count - 1
        guard let postURL = post.attachments[0].sizes[imageIndex].url else { return }

        ImageDownloader.shared.downloadImage(fromURL: postURL, imageCache: nil) { (image) in
            DispatchQueue.main.async {
                self.postImageView.image = image
            }
        }
        
        guard let group = group else { return }
        groupNameLabel.text = group.name
        
        guard let groupURL = group.smallPhotoURL else { return }
        ImageDownloader.shared.downloadImage(fromURL: groupURL, imageCache: nil) { (image) in
            DispatchQueue.main.async {
                self.groupImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
