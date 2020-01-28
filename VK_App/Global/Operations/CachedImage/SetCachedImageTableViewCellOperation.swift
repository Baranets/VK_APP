//
//  SetCachedImageTableViewCell.swift
//  VK_App
//
//  Created by Maxim Baranets on 28.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class SetCachedImageTableViewCellOperation: Operation {
    
    private lazy var cachedImage: UIImage? = {
        return (dependencies.first as? GetCachedImageOperation)?.loadedImage
    }()
    
    private let indexPath: IndexPath
    private let tableView: UITableView
    private let cell: UITableViewCell
    private let completion: ((UIImage?) -> ())?
    
    init(tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath, completion: ((UIImage?) -> ())? = nil) {
        self.tableView = tableView
        self.cell = cell
        self.indexPath = indexPath
        self.completion = completion
        
        super.init()
    }

    override func main() {
        guard let image = cachedImage else { return }
        if let currentIndexPath = tableView.indexPath(for: cell),
            currentIndexPath == indexPath {
            completion?(image)
        } else if tableView.indexPath(for: cell) == nil {
            completion?(image)
        }
    }
    
}
