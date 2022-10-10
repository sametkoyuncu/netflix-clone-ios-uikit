//
//  Movie.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 26.09.2022.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
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

/*
 
 {
adult = 0;
"backdrop_path" = "/pdD47rPAYKVdPasoyhSAFPIFIWo.jpg";
"genre_ids" =             (
 28,
 35,
 53
);
id = 718930;
"media_type" = movie;
"original_language" = en;
"original_title" = "Bullet Train";
overview = "Unlucky assassin Ladybug is determined to do his job peacefully after one too many gigs gone off the rails. Fate, however, may have other plans, as Ladybug's latest mission puts him on a collision course with lethal adversaries from around the globe\U2014all with connected, yet conflicting, objectives\U2014on the world's fastest train.";
popularity = "754.124";
"poster_path" = "/tVxDe01Zy3kZqaZRNiXFGDICdZk.jpg";
"release_date" = "2022-07-03";
title = "Bullet Train";
video = 0;
"vote_average" = "7.4";
"vote_count" = 880;
}
 
 */
