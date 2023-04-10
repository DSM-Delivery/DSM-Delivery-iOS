import Foundation

struct RiderListModel: Codable {
    let riderList: [RiderList]
    enum CodingKeys: String, CodingKey {
        case riderList = "post_list"
    }
}

struct RiderList: Codable {
    let title: String
    let userName: String
    let cost: String
    let postId: String
    let profileImage: String
    let star: Int
    enum CodingKeys: String, CodingKey {
        case title
        case userName = "user_name"
        case cost
        case postId = "post_id"
        case profileImage = "profile_img"
        case star
    }
}
