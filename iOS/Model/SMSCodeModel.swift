import Foundation

struct SMSCodeModel: Codable {
    let code: String
    enum CodingKeys: String, CodingKey {
        case code = "sms_number"
    }
}
