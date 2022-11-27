//
//  Friend.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/26.
//

import Foundation

struct FriendList: Equatable {
    var name: String
    var address: String
}

extension FriendList {
    static var dummy: FriendList {
        FriendList(
            name: ["정우재","박병관","임동현", "김준호", "우준성", "최민재", "김도현", "기준", "금현호"].randomElement() ?? "",
            address: [
                "대구시 수성구에 있는 코롱",
                "대구시 수성구 노변로 89",
                "대구시 수성구 시지 월드메르디앙",
                "대구시 수성구 평리동 어딘가",
                "경기도 광주시 어딘가",
                "포항 어딘가",
                "대구시 북구 어딘가",
                "경상남도 창원시 진해구 어딘가",
                "대구시 달서구 어딘가"
            ].randomElement() ?? ""
        )
    }
}
