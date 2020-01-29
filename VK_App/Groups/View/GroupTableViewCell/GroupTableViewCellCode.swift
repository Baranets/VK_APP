//
//  GroupTableViewCellCode.swift
//  VK_App
//
//  Created by Maxim Baranets on 29.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

class GroupTableViewCellCode: UITableViewCell {
    
    static var preferredRowHeight: CGFloat {
        return 38.0
    }
    
    var group: VKGroup? {
        didSet {
            guard let group = self.group else { return }
            
            groupNameLabel.text = group.name
            addGroupButton.isHidden = group.isMember == 1
            
            guard let url = URL(string: group.photo100) else { return }
            
            groupImageView.af_setImage(withURL: url,
                                       placeholderImage: UIImage(),
                                       progressQueue: .global(qos: .userInteractive),
                                       imageTransition: .crossDissolve(0.2),
                                       runImageTransitionIfCached: false)
        }
    }
    
    let groupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let layer = imageView.layer
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 15.0
        
        return imageView
    }()
    
    let groupNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addGroupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(imageLiteralResourceName: "add")
        button.setImage(image, for: .normal)
        
        let layer = button.layer
        layer.borderColor = button.tintColor.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 15.0
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [groupImageView, groupNameLabel, addGroupButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
        
        setImageViewConstraints()
        setButtonConstraints()
        setStackViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageViewConstraints() {
        groupImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        groupImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setButtonConstraints() {
        addGroupButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addGroupButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setStackViewConstraints() {
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
    }
}
