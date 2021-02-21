//
//  NetworkMiddleLayer.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import Foundation

struct NetworkHandler {
    static let shared = NetworkHandler()
    
    func request<T: Codable>(router : MovieRouter, completion: @escaping (Result<T,Error>) -> ()) {
        guard let url = URL.prepareUrlFromRouter(router: router) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard response != nil, let data = data else {
                completion(.failure(error!))
                return
                
            }

            if let responseObject = try? JSONDecoder().decode(T.self, from: data){
                completion(.success(responseObject))
            }
            
        }
        dataTask.resume()
    }
    
    
}


