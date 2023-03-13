//
//  LoginDataModel.swift
//  DSM-Delivery
//
//  Created by 박도연 on 2023/02/10.
//  Copyright © 2023 com.DSM-Delivery. All rights reserved.
//

import Foundation
struct TokenModel: Codable {
    let access_token: String
    let refresh_token: String
}
