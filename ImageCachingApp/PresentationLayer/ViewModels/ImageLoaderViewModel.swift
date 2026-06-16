//
//  ImageLoaderViewModel.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class ImageLoaderViewModel: ObservableObject {
    
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    private let fetchImageUseCase : FetchImageUseCaseProtocol
    private var downloadTask : Task<Void,Never>?
    
    init(_fetchImageUseCase : FetchImageUseCaseProtocol) {
        self.fetchImageUseCase = _fetchImageUseCase
    }
    
    func loadImage(from url: URL) {
        
        isLoading = true
        
        //Cancel any existing task if this call is being reused
        downloadTask?.cancel()
        
        downloadTask = Task {
            let result = await fetchImageUseCase.execute(url: url)
            
            //Check if task was cancelled during network call to avoid UI flickering
            guard !Task.isCancelled else {return}
            
            switch result {
                
            case .success(let appImage) :
                self.image = UIImage(data: appImage.data)
                
            case .failure:
                self.image = UIImage(systemName: "photo.on.rectagnle.angled") // Fallback
            }
            self.isLoading = false
        }
    }
    
    func cancelLoad() {
        downloadTask?.cancel()
        downloadTask = nil
    }
}
