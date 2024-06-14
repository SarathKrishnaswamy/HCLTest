//
//  PhotoModel.swift
//  LoadImages
//
//  Created by Sarath krishnaswamy on 14/06/24.
//

import Foundation

struct PhotoModel: Codable {
    let total: Int
    let totalHits: Int
    let hits: [Hit]
    
    struct Hit: Codable {
        let id: Int
        let pageURL: String
        let type: String
        let tags: String
        let previewURL: String
    }
}
