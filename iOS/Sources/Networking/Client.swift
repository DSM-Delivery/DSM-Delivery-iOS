//
//  Client.swift
//  DSM-Delivery
//
//  Created by 박도연 on 2023/02/09.
//  Copyright © 2023 com.DSM-Delivery. All rights reserved.
//

import Foundation
import Moya

let MY = MoyaProvider<API>()

enum API {
    case login(id: String, password: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http:")!
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
        case .login(let id, let password):
            return .requestJSONEncodable(["userId":"\(id)", "password":"\(password)"])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login:
            return Header.tokenIsEmpty.header()
        }
    }
}
