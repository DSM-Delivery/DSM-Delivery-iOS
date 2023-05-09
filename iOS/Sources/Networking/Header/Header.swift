import Foundation

struct Token {
    static var nAccessToken: String?
    static var accessToken: String? {
        get {
            nAccessToken = UserDefaults.standard.string(forKey: "accessToken")
            return nAccessToken
        }
        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
            nAccessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
    }
    static var nRefreshToken: String?
    static var refreshToken: String? {
        get {
            nRefreshToken = UserDefaults.standard.string(forKey: "refreshToken")
            return nRefreshToken
        }
        set(newRefreshToken) {
            UserDefaults.standard.set(newRefreshToken, forKey: "refreshToken")
            UserDefaults.standard.synchronize()
            nRefreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        }
    }
    static func removeToken() {
        accessToken = nil
        refreshToken = nil
    }
}

enum Header {
    case accessToken, tokenIsEmpty, refreshToken
    func header() -> [String: String]? {
        guard let accesstoken = Token.accessToken else {
            return ["Contect-Type": "application/json"]
        }
        guard let refreshToken = Token.refreshToken else {
            return ["Contect-Type": "application/json"]
        }
        switch self {
        case .accessToken:
            return ["Authorization": "Bearer " + accesstoken, "Contect-Type": "application/json"]
        case .tokenIsEmpty:
            return ["Contect-Type": "application/json"]
        case .refreshToken:
                    return ["Refresh-Token": "Bearer " + refreshToken, "Contect-Type": "application/json"]

        }
    }
}
