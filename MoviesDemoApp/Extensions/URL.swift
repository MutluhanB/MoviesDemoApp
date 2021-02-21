//
//  URL.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import Foundation

extension URL {
    static func getPosterUrlFromPath(posterPath: String?, width: Int) -> URL?{
        guard let posterPath = posterPath else { return nil}
        let craftedUrlString = "https://image.tmdb.org/t/p/w\(width)\(posterPath)"
        guard let url = URL(string: craftedUrlString) else { return nil}
        return url
    }
    
    static func prepareUrlFromRouter(router: RouterProtocol) -> URL?{
        var components = URLComponents()
        components.scheme = "https"
        components.host = router.baseUrl
        components.path = router.path
        components.queryItems = router.parameters
        return components.url
        
    }
}
