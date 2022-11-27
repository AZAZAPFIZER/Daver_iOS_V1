//
//  TokenRefreshRequest.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

class TokenRefreshRequest: Codable {
    let refreshToken: String

    init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
