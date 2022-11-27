//
//  Member.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/10/17.
//

class Member {
    var id: String? = ""
    var joinedAt: String? = ""
    var name: String? = ""
    var profileImage: String? = ""
    
    private enum MemberKey: String, CodingKey {
        case id
        case joinedAt
        case name
        case profileImage
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.container(keyedBy: MemberKey.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.joinedAt = try container.decodeIfPresent(String.self, forKey: .joinedAt) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
    }
    
}
