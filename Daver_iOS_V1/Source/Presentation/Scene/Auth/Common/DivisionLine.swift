//
//  DivisionLine.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/21.
//

import UIKit

final class DivisionLine: UIView{
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.backgroundColor = UIColor(named: "Daver_Gray")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
