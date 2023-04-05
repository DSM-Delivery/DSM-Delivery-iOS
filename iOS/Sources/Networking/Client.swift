import Foundation
import Moya

enum API {
    //user
    case login(accountId: String, password: String)
    case signup(accountId: String, password: String, phone: String)
    case sendNumber(number: String)
    case numberCheck(number: String, numberCode: String)

    case requestList
    case refreshToken
//    case requestListLookUP
//    case riderPostList
//    case writePost
//    case detailPost
//    case detailPostSelectProduct
//    case deliveried
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
        case .refreshToken:
            return "/user/token"
        case .requestList:
            return "/post/order"

        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signup, .sendNumber:
            return .post
        case .numberCheck:
            return .put
        case .requestList:
            return .get
        case .refreshToken:
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
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        case .login, .signup, .sendNumber, .numberCheck:
            return Header.tokenIsEmpty.header()
        case .requestList:
            return Header.accessToken.header()
        case .refreshToken:
            return Header.refreshToken.header()            
        }
    }
}
