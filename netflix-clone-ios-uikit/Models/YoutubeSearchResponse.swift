//
//  YoutubeSearchResponse.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 15.10.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: VideoElementId
}

struct VideoElementId: Codable {
    let kind: String
    let videoId: String
}
