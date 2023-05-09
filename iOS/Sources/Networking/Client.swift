import Foundation
import Moya

enum API {
// user
    case login(accountId: String, password: String)
    case signup(accountId: String, password: String, phone: String, name: String, sex: String, role: String)
    case sendNumber(number: String)

    case requestList
    case refreshToken
    case riderList
//    case writePost
//    case selectObject

//    case requestListLookUP
//    case writePost
//    case detailPost
//    case detailPostSelectProduct
//    case deliveried
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://172.20.10.4:8080")!
    }
    var path: String {
        switch self {
        case .login:
            return "/user/auth"
        case .signup:
            return "/user/register"
        case .sendNumber(let number):
            return "/user/sendSMS/\(number)"

        case .refreshToken:
            return "/user/token"
        case .requestList:
            return "/post/order"
        case .riderList:
            return "/post/rider"
//        case .writePost
//            return "/post"
//            case selectObjec
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .signup:
            return .post
        case .requestList, .riderList, .sendNumber:
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
        case .signup(let accountId, let password, let phone, let name, let sex, let role):
            return .requestParameters(parameters:
                                        [
                                            "account_id": accountId,
                                            "password": password,
                                            "phone": phone,
                                            "name": name,
                                            "sex": sex,
                                            "role": role
                                        ], encoding: JSONEncoding.default)
//        case .numberCheck(let number, let numberCode):
//            return.requestParameters(parameters:
//                                        [
//                                            "number": number,
//                                            "numbercode": numberCode
//                                        ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        case .login, .signup, .sendNumber:
            return Header.tokenIsEmpty.header()
        case .requestList, .riderList:
            return Header.accessToken.header()
        case .refreshToken:
            return Header.refreshToken.header()
        }
    }
}
