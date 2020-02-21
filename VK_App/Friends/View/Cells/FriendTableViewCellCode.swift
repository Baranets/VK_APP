//
//  FriendTableViewCellCode.swift
//  VK_App
//
//  Created by Maxim Baranets on 29.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

class FriendTableViewCellCode: UITableViewCell {
    
    static var preferredRowHeight: CGFloat {
        return 76.0
    }
    
    weak var friend: VKFriend? {
        didSet {
            guard let friend = friend else { return }
            
            nameLabel.text = friend.fullSurname
            onlineLabel.text = friend.isOnline ? "online" : "offline"
            onlineLabel.textColor = friend.isOnline ? .systemGreen : .systemGray
            guard let url = friend.photoURL else { return }
            userImageView.kf.setImage(
                with: url,
                placeholder: UIImage(),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
            ])
        }
    }
    
    let userImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let layer = imageView.layer
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 30.0
        
        return imageView
    }()
    
    let nameLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    let onlineLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, onlineLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4.0
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(userImageView)
        addSubview(stackView)

        setImageViewConstraints()
        setStackViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageViewConstraints() {
        userImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 60.0).isActive  = true
        userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
    }
    
    func setStackViewConstraints() {
        stackView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16.0).isActive = true
    }
}
