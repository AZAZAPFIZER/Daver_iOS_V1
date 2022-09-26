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
    
    func leftSpace(_ space: CGFloat) {
        let spacer = UIView()
        spacer.pin.width(space).height(of: self)
        leftView = spacer
        leftViewMode = .always
    }
    func rightSpace(_ space: CGFloat) {
        let spacer = UIView()
        spacer.pin.width(space).height(of: self)
        rightView = spacer
        rightViewMode = .always
    }
    func addLeftImage(image: UIImage, space: CGFloat = 10) {
        let leftImage = UIImageView(image: image)
        let view = UIView()
        view.addSubViews(leftImage)
        leftImage.pin.left(space).vCenter()
        self.leftView = view
        self.leftViewMode = .always
    }
    func addRightImage(image: UIImage, space: CGFloat = 10) {
        let rightImage = UIImageView(image: image)
        let view = UIView()
        view.addSubViews(rightImage)
        rightImage.pin.right(space).vCenter()
        self.rightView = view
        self.rightViewMode = .always
    }
}
