//
//  Movie.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 26.09.2022.
//

import Foundation

struct TitleResponse: Codable {
    let results: [Title]
}
 
struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
