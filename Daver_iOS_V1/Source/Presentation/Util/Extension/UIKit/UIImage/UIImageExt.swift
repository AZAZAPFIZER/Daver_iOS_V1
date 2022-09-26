//
//  UIImageExt.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/21.
//

import UIKit

extension UIImage{
    func tintColor(_ color: UIColor) -> UIImage{
        return self.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
