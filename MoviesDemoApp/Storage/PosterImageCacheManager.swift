//
//  PosterImageCacheManager.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 21.02.2021.
//

import Foundation
import UIKit

struct PosterImageCacheManager {
    static let shared = PosterImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init(){
        
    }
    
    public func addImageToCache(key: NSString, image: UIImage) {
        if getCachedImage(key: key) == nil {
            cache.setObject(image, forKey: key)
        }

    }
    
    
    public func removeImageFromCache(key: NSString, image: UIImage) {
        if isImageExistInCache(key: key) {
            cache.removeObject(forKey: key)
        }
    }
    
    public func getCachedImage(key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    public func isImageExistInCache(key: NSString) -> Bool {
        return getCachedImage(key: key) != nil
    }
    
    
}
