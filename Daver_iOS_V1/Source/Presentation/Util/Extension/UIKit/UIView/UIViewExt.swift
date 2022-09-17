//
//  UIViewExt.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import UIKit

extension UIView{
    func addSubViews(_ subView: UIView...){
        subView.forEach(addSubview(_:))
    }
}
