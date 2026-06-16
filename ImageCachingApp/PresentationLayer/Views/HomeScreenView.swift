//
//  HomeScreenView.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import SwiftUI

struct HomeScreenView: View {
    
    let imageUrls : [URL]
    let useCase : FetchImageUseCaseProtocol // Inject via Depedency Injection Container
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    
                    ForEach(imageUrls, id: \.self) { url in
                        AsyncRowImageView(_url: url, _useCase: useCase)
                            .frame(height: 400)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Clean Gallery")
    }
}




