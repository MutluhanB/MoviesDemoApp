//
//  MovieDetail.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 19.02.2021.
//

import Foundation

struct MovieDetail: Codable {
    var id: Int?
    var title: String?
    var overview: String?
    var vote_average: Double?
    var vote_count: Int?
    var poster_path: String?
}
