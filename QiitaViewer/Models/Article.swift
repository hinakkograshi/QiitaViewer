//
//  Article.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import Foundation

struct Article: Decodable, Identifiable {
    let id: String
    let likeCount: Int
    let title: String
    let user: User
    enum CodingKeys: String, CodingKey {
        case id
        case likeCount = "likes_count"
        case title
        case user
    }
}

struct User: Decodable {
    let name: String
    let profileImageURL: URL

    enum CodingKeys: String, CodingKey {
        case name
        case profileImageURL = "profile_image_url"
    }
}
