//
//  ImageCacheService.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import Foundation

protocol ImageCacheServiceProtocol {
    func get(for url: URL) -> Data?
    func set(_ data: Data, for url: URL)
}


final class ImageCacheService : ImageCacheServiceProtocol {
   
    private let memoryCache = NSCache<NSURL,NSData>()
    private let fileManager = FileManager.default
    private let diskCacheURL : URL
    
    
    init() {
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.diskCacheURL = cacheDirectory.appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }
    
    func get(for url: URL) -> Data? {
        
        //Check Memory Cache
        if let nsData = memoryCache.object(forKey: url as NSURL) {
            return nsData as Data
        }
        
        //Check Disk Cache
        let fileURL = diskCacheURL.appendingPathComponent(url.lastPathComponent)
        if let data = try? Data(contentsOf: fileURL) {
            memoryCache.setObject(data as NSData, forKey: url as NSURL)
            return data
        }
        
        return nil
    }
    
    func set(_ data: Data, for url: URL) {
        
        //Save to Memory
        memoryCache.setObject(data as NSData, forKey: url as NSURL)
        
        //Save to Disk(Offloaded asynchronously to avoid blocking)
        let fileURL = diskCacheURL.appendingPathComponent(url.lastPathComponent)
        
        Task.detached(priority: .background) {
            try? data.write(to: fileURL)
        }
    }
}
