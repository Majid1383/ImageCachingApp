//
//  AsyncRowImageView.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import SwiftUI

struct AsyncRowImageView: View {
    
    let url: URL
    @StateObject private var viewModel : ImageLoaderViewModel
    
    init(_url: URL, _useCase: FetchImageUseCaseProtocol) {
        self.url = _url
        self._viewModel = StateObject(wrappedValue: ImageLoaderViewModel(_fetchImageUseCase: _useCase))
    }
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }else if viewModel.isLoading {
                ProgressView()
            } else {
                Color.gray.opacity(0.2) // Placeholder
            }
        }
        .onAppear{
            viewModel.loadImage(from: url)
        }
        .onDisappear {
            viewModel.cancelLoad()
        }
    }
}


