//
//  GroupTableViewCell.swift
//  VK_App
//
//  Created by Maxim Baranets on 09.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    class var cellIdentifire: String {
        return "GroupTableViewCell"
    }
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var addGroupButton: UIButton!
    
    var group: Group? {
        didSet {
            guard let group = self.group else { return }
            
            groupNameLabel.text = group.name
            addGroupButton.isHidden = group.isMember
            
            guard let url = URL(string: group.urlPhotoString ?? "") else { return }
               
           ImageDownloader.shared.downloadImage(fromURL: url, imageCache: nil) { (image) in
               DispatchQueue.main.async {
                self.groupImageView.image = image
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
    
    @IBAction func pressedAddGroupButton(_ sender: Any) {
        guard let group = self.group else { return }
        VKGroup().join(group_id: group.id)
            DispatchQueue.main.async {
                self.addGroupButton.isHidden = true
        }
    }
    
    
    private func configure() {
        let layer = groupImageView.layer
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = groupImageView.frame.size.width / 2
    }
}
