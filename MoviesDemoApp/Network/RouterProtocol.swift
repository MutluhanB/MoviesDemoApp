//
//  RouterProtocol.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 20.02.2021.
//

import Foundation

protocol RouterProtocol {
    var baseUrl: String {get}
    var path: String {get}
    var parameters: [URLQueryItem] {get}
    var method : String {get}
    
}
