//
//  SignInResponse.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/17.
//

class SignInResponse: Codable {
    var accessToken: String?
    var refreshToken: String?
    var member: Member?

    enum DataKey: String, CodingKey {
        case accessToken
        case refreshToken
        case member
    }

    required init(from decoder: Decoder) throws {}
    func encode(to encoder: Encoder) throws {}
    
}
