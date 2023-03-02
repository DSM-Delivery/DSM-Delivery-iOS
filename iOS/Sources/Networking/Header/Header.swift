
import Foundation

struct Token {
    static var _accessToken: String?
    static var accessToken: String? {
        get {
            _accessToken = UserDefaults.standard.string(forKey: "accessToken")
            return _accessToken
        }
        set(newToken) {
            UserDefaults.standard.set(newToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
            _accessToken = UserDefaults.standard.string(forKey: "accessToken")
        }
    }
    static var _refreshToken: String?
    static var refreshToken: String? {
        get {
            _refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
            return _refreshToken
        }

        set(newRefreshToken) {
            UserDefaults.standard.set(newRefreshToken, forKey: "refreshToken")
            UserDefaults.standard.synchronize()
            _refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        }
    }
    
    static func removeToken() {
        accessToken = nil
        refreshToken = nil
    }
}

enum Header {
    case accessToken, tokenIsEmpty
    
    func header() -> [String : String]? {
        guard let token = Token.accessToken else {
            return ["Contect-Type" : "application/json"]
        }
            switch self {
                   case .accessToken:
                       return ["Authorization" : "Bearer " + token, "Contect-Type" : "application/json"]
                
                   case .tokenIsEmpty:
                       return ["Contect-Type" : "application/json"]
                   }
        }
}

    

    
    
    

