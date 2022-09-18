//
//  UITextFieldExt.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/18.
//

import Foundation
import UIKit

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor){
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 48, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
