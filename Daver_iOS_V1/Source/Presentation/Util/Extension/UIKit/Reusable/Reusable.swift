//
//  Reusable.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/11/26.
//

import UIKit

protocol ReuseIdentifiable{
    static var reusableID: String { get }
}
extension ReuseIdentifiable{
    static var reusableID: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
