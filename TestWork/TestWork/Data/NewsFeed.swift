import Foundation

struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int?
    var articles: [Article]
}
