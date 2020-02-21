//
//  GetCachedImageOperation.swift
//  VK_App
//
//  Created by Maxim Baranets on 28.01.2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import Foundation
import UIKit

class GetCachedImageOperation: Operation {
    
    private static let cacheDirPath: String = {
        let dirName = "cachedImages"
        let fileManager = FileManager.default
        
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return dirName }
        print(cachesDirectory)
        let url = cachesDirectory.appendingPathComponent(dirName, isDirectory: true)
        
        if !fileManager.fileExists(atPath: url.path) {
            try? fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return dirName
    }()
    
    private lazy var filePath: String? = {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = String(describing: url.hashValue)
        
        return cachesDirectory.appendingPathComponent(GetCachedImageOperation.cacheDirPath + "/" + hashName).path
    }()
    
    private let cacheLifeTime: TimeInterval = 3600
    
    let url: URL
    var loadedImage: UIImage?
    
    init(url: URL) {
        self.url = url
    }
    
    init?(string: String) {
        guard let url = URL(string: string) else { return nil }
        self.url = url
    }
    
    override func main() {
        
        guard filePath != nil && !isCancelled else { return }
        
        guard !getImageFromCache() && !isCancelled else { return }
        
        guard downloadImage() && !isCancelled else { return }
        
        saveImageToCache()
    }
    
    private func getImageFromCache() -> Bool {
        guard let fileName = filePath,
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return false }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName)
            else { return false }
        
        self.loadedImage = image
        
        return true
    }
    
    private func downloadImage() -> Bool {
        guard let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) else { return false }
        
        self.loadedImage = image
        
        return true
    }
    
    private func saveImageToCache() {
        guard let fileName = filePath,
            let image = self.loadedImage
            else { return }
        
        let data = image.pngData()
        
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
}
