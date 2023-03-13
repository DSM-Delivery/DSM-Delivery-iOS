import Foundation
import Moya

let MY = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])

enum API {
    case login(account_id: String, password: String)
//    case signup(account_id: String, password: String, name: String, gender: String, phone: String, role: String)
    //    case signup(account_id: String, password: String, name: String, image_path: String,phone_number: String, sex: String, role: String)
}

extension API: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://172.20.10.6:8080")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/auth"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
            
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let account_id, let password):
            return .requestJSONEncodable(["account_id":"\(account_id)", "password":"\(password)"])
  
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login:
            return Header.tokenIsEmpty.header()
        }
    }
}

