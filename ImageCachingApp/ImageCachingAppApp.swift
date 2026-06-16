//
//  ImageCachingAppApp.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

///Gemini Reference - https://share.gemini.google/oZ5kFLGOHXwb

import SwiftUI

@main
struct ImageCachingAppApp: App {
    
    private let sampleURLs: [URL] = [
            URL(string: "https://picsum.photos/id/10/500/400")!,
            URL(string: "https://picsum.photos/id/20/500/400")!,
            URL(string: "https://picsum.photos/id/30/500/400")!,
            URL(string: "https://picsum.photos/id/40/500/400")!,
            URL(string: "https://picsum.photos/id/50/500/400")!,
            URL(string: "https://picsum.photos/id/10/500/400")!,
            URL(string: "https://picsum.photos/id/20/500/400")!,
            URL(string: "https://picsum.photos/id/30/500/400")!,
            URL(string: "https://picsum.photos/id/40/500/400")!,
            URL(string: "https://picsum.photos/id/50/500/400")!,
            URL(string: "https://picsum.photos/id/10/500/400")!,
            URL(string: "https://picsum.photos/id/20/500/400")!,
            URL(string: "https://picsum.photos/id/30/500/400")!,
            URL(string: "https://picsum.photos/id/40/500/400")!,
            URL(string: "https://picsum.photos/id/50/500/400")!
        ]
    
    private var fetchImageUseCase: FetchImageUseCaseProtocol {
            // Concrete Cache Service (Data Layer)
            let cacheService = ImageCacheService()
            
            // Concrete Repository (Data Layer)
        let repository = ImageRepository(_cacheService: cacheService)
            
            // Concrete Use Case (Domain Layer)
        return FetchImageUseCase(_repository: repository)
        }
    
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView(imageUrls: sampleURLs, useCase: fetchImageUseCase)
        }
    }
}
