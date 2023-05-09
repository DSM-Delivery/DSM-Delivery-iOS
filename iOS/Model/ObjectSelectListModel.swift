import Foundation

struct ObjectSelectListModel: Codable {
    let postID: String
    let selectionList: [SelectionList]

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case selectionList = "selection_list"
    }
}

struct SelectionList: Codable {
    let productID, quantity, productType: String

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case quantity
        case productType = "product_type"
    }
}
