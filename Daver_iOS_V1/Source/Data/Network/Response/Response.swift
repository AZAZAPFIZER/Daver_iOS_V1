//
//  Response.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/19.
//

class Response<T: Codable>: Codable {
    var status: Int
    var message: String
    var data: T
}

class MessageResponse: Codable {
    var status: Int
    var message: String
}
