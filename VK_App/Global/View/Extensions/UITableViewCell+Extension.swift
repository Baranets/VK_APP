//
//  UITableViewCell+Extension.swift
//  VK_App
//
//  Created by Maxim Baranets on 26.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    class var cellIdentifier: String {
        return String(describing: Self.self)
    }
    
    class var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
}
