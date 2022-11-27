//
//  FriendSection.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/26.
//

import RxDataSources
import UIKit

struct FriendSection: SectionModelType {
    var items: [FriendList]
}

extension FriendSection {
    typealias Item = FriendList
    
    init(original: FriendSection, items: [FriendList]) {
        self = original
        self.items = items
    }
}
