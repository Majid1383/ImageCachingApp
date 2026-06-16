//
//  FetchImageUseCase.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import Foundation

protocol FetchImageUseCaseProtocol {
    func execute(url: URL) async -> Result<AppImage, Error>
}


final class FetchImageUseCase : FetchImageUseCaseProtocol {
    
    private let repository : ImageRepositoryProtocol
    
    init( _repository: ImageRepositoryProtocol) {
        self.repository = _repository
    }
    
    func execute(url: URL) async -> Result<AppImage, any Error> {
        return await repository.loadImage(from: url)
    }
}
