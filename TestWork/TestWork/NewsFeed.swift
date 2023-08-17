//
//  NewsModel.swift
//  TestWork
//
//  Created by Natalie Mikheeva on 14.08.2023.
//

import Foundation

struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int?
    var articles: [Article]
}
