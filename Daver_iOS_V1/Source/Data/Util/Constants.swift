//
//  Constants.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

import Foundation

struct Constants {
    static let DEFAULT_HOST = "http://10.80.162.42:8082/"
    static let INFINITE_SCROLL_LIMIT = 20
    static let ACCESS_TOKEN = "Bearer " + AuthController.getInstance().getToken()
}
