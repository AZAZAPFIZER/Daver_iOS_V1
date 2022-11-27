//
//  UnderLineTextField.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/09/18.
//

import UIKit

final class UnderLineTextField: UITextField {
    
    init(ph: String? = "") {
        super.init(frame: .zero)
        self.placeholder = ph
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
