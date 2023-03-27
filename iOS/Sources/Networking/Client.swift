import Foundation
import Moya

enum API {
    case login(accountId: String, password: String)
    case signup(accountId: String, password: String, phone: String)
    case sendNumber(number: String)
    case numberCheck(number: String, numberCode: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://172.20.10.6:8080")!
    }
    var path: String {
        switch self {
        case .login:
            return "/user/auth"
        case .signup:
            return "/user/register"
        case .sendNumber:
            return "/user/number"
        case .numberCheck:
            return "/user/numberCheck"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signup, .sendNumber:
            return .post
        case .numberCheck:
            return .put
        }
    }
    var task: Moya.Task {
        switch self {
        case .login(let accountId, let password):
            return .requestParameters(parameters:
                                        [
                                            "account_id": accountId,
                                            "password": password
                                        ], encoding: JSONEncoding.default)
        case .signup(let accountId, let password, let phone):
            return .requestParameters(parameters:
                                        [
                                            "account_id": accountId,
                                            "password": password,
                                            "phone": phone
                                        ], encoding: JSONEncoding.default)
        case .sendNumber(let number):
            return.requestParameters(parameters:
                                        [
                                            "number": number
                                        ], encoding: JSONEncoding.default)
        case .numberCheck(let number, let numberCode):
            return.requestParameters(parameters:
                                        [
                                            "number": number,
                                            "numbercode": numberCode
                                        ], encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .login, .signup, .sendNumber, .numberCheck:
            return Header.tokenIsEmpty.header()
        }
    }
}
