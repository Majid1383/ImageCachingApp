//
//  ImageRepositoryProtocol.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import Foundation

protocol ImageRepositoryProtocol {
    func loadImage(from url: URL) async -> Result<AppImage,Error>
}

final class ImageRepository : ImageRepositoryProtocol {
    
    private let cacheService: ImageCacheServiceProtocol
    private let session: URLSession
    
    init(_cacheService : ImageCacheServiceProtocol, _session : URLSession = .shared) {
        self.cacheService = _cacheService
        self.session = _session
    }
    
    func loadImage(from url: URL) async -> Result<AppImage, any Error> {
        
        //1.Try Cache First
        if let cachedData = cacheService.get(for: url) {
            return .success(AppImage(url: url, data: cachedData))
        }
        
        //2.Fetch from Network if not cached
        
        do{
            let (data,response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(URLError(.badServerResponse))
            }
            
            //3. Save to Cache
            cacheService.set(data, for: url)
            
            return .success(AppImage(url: url, data: data))
            
        }catch{
            return .failure(error)
        }
    }
}
