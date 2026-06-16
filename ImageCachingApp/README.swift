//
//  README.swift
//  ImageCachingApp
//
//  Created by Abdul Majid Shaikh on 16/06/26.
//

import Foundation

/*
 
 Clean Architecure has basically 3 Layers
 
 Domain Layer - Business Logic. Completely independent of UIKit/SwiftUI & URLSession. Contains the Entity and the UseCase protocol.
 
 DATA LAYER - Concrete implementations. Contains the Repository, the API service(URLSession), and the CacheService(NSCache + File Manager)
 
 PRESENTATION LAYER - SwiftUI View & ViewModel. Listens to the UseCase and ensures the UI udpates happen on the @MainActor.
 
 */
