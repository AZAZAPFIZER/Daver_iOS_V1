//
//  UINavigationExt.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/05.
//

import UIKit

extension UINavigationItem{
    func setTitle(title: String){
        let lb = UILabel()
        lb.text = title
        lb.textColor = .label
        lb.font = .systemFont(ofSize: 16, weight: .medium)
        self.titleView = lb
    }
    func configBack(){
        let back = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        back.tintColor = .label
        self.backBarButtonItem = back
    }
}
