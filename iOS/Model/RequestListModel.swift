import Foundation

struct RequestListModel: Codable {
    let postList: [RequestList]
    enum CodingKeys: String, CodingKey {
        case postList = "post_list"
    }
}

struct RequestList: Codable {
    let title: String
    let userName: String
    let cost: Int
    let postId: String
    let profileImg: String
    let productType: String
    enum CodingKeys: String, CodingKey {
        case title
        case userName = "user_name"
        case cost
        case postId = "post_id"
        case profileImg = "profile_img"
        case productType = "product_type"
    }
}
